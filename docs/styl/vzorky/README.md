# Vzorky grafiky

Sem patří obrázky vygenerované podle zadání ve [stylové bibli](../../06-stylova-bible.md).
Generují se skriptem `tools/generuj_vzorky.py` (viz stylová bible, část Automatické generování),
nebo ručně v ChatGPT se stejným zadáním. Skript ke každému obrázku uloží stejnojmenný `.json`
s úplným zadáním, modelem a datem a přidá řádek do tabulky níže; u ručně vytvořených se řádek
doplní ručně. Pojmenování: `<id vzorku>_v01.png`, další pokus `_v02`. Schválené vzorky se označí ☑.
Hodnocení kol: [kolo 1](hodnoceni-kolo-1.md). Zadání ke zkopírování: [kolo 2](zadani-kolo-2.md). Hodnocení kola 2: [postavy a pozadí](hodnoceni-kolo-2.md), tam jsou i zadání pro kolo 3.

| Soubor | Nástroj | Zadání | Schváleno |
|---|---|---|---|
| a-namesti_v01.png | ChatGPT (ručně) | zadání `a-namesti` z tools/vzorky/zadani.json | ☐ ([hodnocení](hodnoceni-kolo-1.md)) |
| a-archiv_v01.png | ChatGPT (ručně) | zadání `a-archiv` | ☐ |
| a-rampa_v01.png | ChatGPT (ručně) | zadání `a-rampa` | ☐ |
| c-namesti-vecer_v01.png | ChatGPT (ručně) | zadání `c-namesti-vecer`, ve stejné konverzaci jako a-namesti | ☐ |
| ruda-list_v01.png | ChatGPT (ručně) | zadání `ruda-list` | ☐ |
| bara-list_v01.png | ChatGPT (ručně) | zadání `bara-list` | ☐ |
| ruda-list_v02.png | ChatGPT (ručně) | zadání `ruda-list` kola 2, předloha ruda-list_v01 | ☑ reference ([hodnocení](hodnoceni-kolo-2.md)) |
| bara-list_v02.png | ChatGPT (ručně) | zadání `bara-list` kola 2, předloha stylu ruda-list_v01 | ☑ reference |
| a-namesti_v02.png | ChatGPT (ručně) | zadání `a-namesti` kola 2, předloha stylu ruda-list_v01 | ☑ směr (D32), v kole 3 zkusit křivost ([hodnocení](hodnoceni-kolo-2.md)) |
| c-namesti-vecer_v02.png | ChatGPT (ručně) | zadání `c-namesti-vecer` kola 2, stejná konverzace jako náměstí | ☑ směr (D32) |
| a-archiv_v02.png | ChatGPT (ručně) | zadání `a-archiv` kola 2 | ☑ vzor interiérů (D32) |
| a-rampa_v02.png | ChatGPT (ručně) | zadání `a-rampa` kola 2 | ☐ znovu (v03) |
| test-postavy-namesti_v02.png | složeno skriptem | ruda/bara-list_v02 na a-namesti_v02 | test |
| test-postavy-archiv_v02.png | složeno skriptem | ruda/bara-list_v02 na a-archiv_v02 | test |
