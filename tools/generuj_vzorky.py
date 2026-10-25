#!/usr/bin/env python3
"""Generuje stylové vzorky přes OpenAI Images API podle tools/vzorky/zadani.json.

Použití:
  python3 tools/generuj_vzorky.py --dry-run           # jen vypíše zadání a odhad ceny
  python3 tools/generuj_vzorky.py                     # vygeneruje všechny vzorky
  python3 tools/generuj_vzorky.py --only ruda-list    # jen vybrané (--only lze opakovat)
  python3 tools/generuj_vzorky.py --quality high      # jiná kvalita (low / medium / high)

API klíč se čte z proměnné prostředí OPENAI_API_KEY nebo ze souboru .env v kořeni projektu
(řádek OPENAI_API_KEY=...). Soubor .env je v .gitignore a nikdy se necommituje.

Vzorek může mít v zadání "reference": seznam cest k obrázkům (relativně ke kořeni projektu).
Pak se použije endpoint pro úpravy a model obrázky vezme jako předlohu, např. referenční list
postavy pro konzistentní vzhled. S "predloha": true se na začátek zadání přidá věta
"predloha_stylu": z předlohy se převezme jen styl, ne postava.
"""
import argparse
import base64
import datetime
import json
import os
import pathlib
import sys
import urllib.error
import urllib.request
import uuid

ROOT = pathlib.Path(__file__).resolve().parent.parent
SPEC = ROOT / "tools" / "vzorky" / "zadani.json"
OUT = ROOT / "docs" / "styl" / "vzorky"
LOG = OUT / "README.md"
API = "https://api.openai.com/v1/images"

# Orientační cena za obrázek 1536×1024 v USD; před větším generováním ověřit v ceníku OpenAI
PRICE = {"low": 0.016, "medium": 0.063, "high": 0.25}


def load_key():
    key = os.environ.get("OPENAI_API_KEY")
    env = ROOT / ".env"
    if not key and env.exists():
        for line in env.read_text().splitlines():
            if line.strip().startswith("OPENAI_API_KEY="):
                key = line.split("=", 1)[1].strip().strip('"').strip("'")
    return key


def build_prompt(spec, item):
    typ = spec["typy"][item["typ"]]
    parts = [typ["uvod"], item["popis"], spec["palety"][item["paleta"]], typ["zaver"]]
    if item.get("predloha"):
        parts.insert(0, spec["predloha_stylu"])
    return ",\n".join(p.strip().rstrip(",") for p in parts)


def send(req):
    try:
        with urllib.request.urlopen(req, timeout=300) as r:
            return json.load(r)
    except urllib.error.HTTPError as e:
        body = e.read().decode(errors="replace")
        sys.exit(f"Chyba API {e.code}: {body}")
    except urllib.error.URLError as e:
        sys.exit(f"Nepodařilo se spojit s API: {e.reason}")


def post_json(url, payload, key):
    req = urllib.request.Request(url, data=json.dumps(payload).encode(), headers={
        "Authorization": f"Bearer {key}", "Content-Type": "application/json"})
    return send(req)


def post_multipart(url, fields, files, key):
    boundary = uuid.uuid4().hex
    body = bytearray()
    for name, value in fields.items():
        body += (f'--{boundary}\r\nContent-Disposition: form-data; name="{name}"\r\n\r\n'
                 f'{value}\r\n').encode()
    for name, path in files:
        mime = "image/jpeg" if path.suffix.lower() in (".jpg", ".jpeg") else "image/png"
        body += (f'--{boundary}\r\nContent-Disposition: form-data; name="{name}"; '
                 f'filename="{path.name}"\r\nContent-Type: {mime}\r\n\r\n').encode()
        body += path.read_bytes() + b"\r\n"
    body += f"--{boundary}--\r\n".encode()
    req = urllib.request.Request(url, data=bytes(body), headers={
        "Authorization": f"Bearer {key}",
        "Content-Type": f"multipart/form-data; boundary={boundary}"})
    return send(req)


def next_path(item_id):
    n = 1
    while (OUT / f"{item_id}_v{n:02d}.png").exists():
        n += 1
    return OUT / f"{item_id}_v{n:02d}.png"


def main():
    ap = argparse.ArgumentParser(description="Generuje stylové vzorky přes OpenAI Images API.")
    ap.add_argument("--only", action="append", help="id vzorku ze zadani.json (lze opakovat)")
    ap.add_argument("--quality", choices=sorted(PRICE), help="přepíše kvalitu ze zadani.json")
    ap.add_argument("--model", help="přepíše model ze zadani.json")
    ap.add_argument("--dry-run", action="store_true", help="jen vypíše zadání, nic negeneruje")
    args = ap.parse_args()

    spec = json.loads(SPEC.read_text())
    model = args.model or spec.get("model", "gpt-image-1")
    quality = args.quality or spec.get("kvalita", "medium")
    known = {i["id"] for i in spec["vzorky"]}
    unknown = set(args.only or []) - known
    if unknown:
        sys.exit(f"Neznámé vzorky: {', '.join(sorted(unknown))}. Známé: {', '.join(sorted(known))}")
    items = [i for i in spec["vzorky"] if not args.only or i["id"] in args.only]
    for i in items:
        for ref in i.get("reference", []):
            if not (ROOT / ref).exists():
                sys.exit(f"Vzorek {i['id']}: referenční obrázek {ref} neexistuje")

    print(f"{len(items)} vzorků, model {model}, kvalita {quality}, "
          f"odhad ≈ ${len(items) * PRICE[quality]:.2f}")
    if args.dry_run:
        for i in items:
            print(f"\n=== {i['id']} ({i['velikost']}) ===\n{build_prompt(spec, i)}")
        return

    key = load_key()
    if not key:
        sys.exit("Chybí API klíč: nastav OPENAI_API_KEY nebo ho zapiš do souboru .env "
                 "v kořeni projektu (OPENAI_API_KEY=...).")

    OUT.mkdir(parents=True, exist_ok=True)
    for i in items:
        prompt = build_prompt(spec, i)
        refs = [ROOT / r for r in i.get("reference", [])]
        print(f"→ {i['id']} …", flush=True)
        if refs:
            res = post_multipart(f"{API}/edits",
                                 {"model": model, "prompt": prompt, "size": i["velikost"],
                                  "quality": quality},
                                 [("image[]", r) for r in refs], key)
        else:
            res = post_json(f"{API}/generations",
                            {"model": model, "prompt": prompt, "size": i["velikost"],
                             "quality": quality, "n": 1}, key)
        path = next_path(i["id"])
        path.write_bytes(base64.b64decode(res["data"][0]["b64_json"]))
        meta = {"id": i["id"], "model": model, "kvalita": quality, "velikost": i["velikost"],
                "paleta": i["paleta"], "reference": i.get("reference", []),
                "datum": datetime.date.today().isoformat(), "zadani": prompt}
        path.with_suffix(".json").write_text(json.dumps(meta, ensure_ascii=False, indent=2) + "\n")
        with LOG.open("a") as f:
            f.write(f"| {path.name} | {model} ({quality}) | {path.with_suffix('.json').name} | ☐ |\n")
        print(f"  uloženo: {path.relative_to(ROOT)}")


if __name__ == "__main__":
    main()
