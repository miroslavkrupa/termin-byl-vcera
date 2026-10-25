# Hra – technický prototyp „Náměstí“

Projekt Godot 4.7 s doplňkem Popochiu 2.2.1 (MIT, `addons/popochiu`). Plán a otázky prototypu
jsou v [docs/08-prototyp-namesti.md](../docs/08-prototyp-namesti.md).

## Otevření

Godot → **Import** → `hra/project.godot` → *Import & Edit*.

## Struktura

| Složka | Obsah |
|---|---|
| `addons/popochiu/` | doplněk Popochiu (neupravovat, při aktualizaci se přepíše) |
| `grafika/mistnosti/` | pozadí místností (kopie schválených vzorků z `docs/styl/vzorky/`) |
| `grafika/postavy/` | postavy vyříznuté z referenčních listů, s průhledným pozadím |
| `texty/` | tabulka řetězců CS/EN |
| `nastroje/` | pomocné skripty |
| `game/` | místnosti, postavy a předměty Popochiu (vytvoří průvodce nastavením) |

## Nástroje

Všechny se spouštějí z kořene repozitáře.

Založení objektu Popochiu bez editoru (příkazy a souřadnice jsou v hlavičce skriptu):

```bash
godot --headless --path hra --script res://nastroje/vytvor.gd -- mistnost Archiv
```

Spuštění hry se snímkem obrazovky (pro ověřování; `dojdi` pošle hráčovu postavu na místo):

```bash
godot --path hra -- snimek=/tmp/snimek.png cekej=3 dojdi=1100,750 po=6
```

Vyříznutí postavy z referenčního listu (odstraní bílé pozadí):

```bash
godot --headless --path hra --script res://nastroje/vyrez_postavy.gd -- <vstup.png> <výstup.png> <x> <y> <šířka> <výška>
```
