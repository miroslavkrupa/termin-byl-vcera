# Vzorky grafiky

Sem patří obrázky vygenerované podle zadání ve [stylové bibli](../../06-stylova-bible.md).
Generují se skriptem `tools/generuj_vzorky.py` (viz stylová bible, část Automatické generování),
nebo ručně v ChatGPT se stejným zadáním. Skript ke každému obrázku uloží stejnojmenný `.json`
s úplným zadáním, modelem a datem a přidá řádek do tabulky níže; u ručně vytvořených se řádek
doplní ručně. Pojmenování: `<id vzorku>_v01.png`, další pokus `_v02`. Schválené vzorky se označí ☑.
Hodnocení kol: [kolo 1](hodnoceni-kolo-1.md). Zadání ke zkopírování: [kolo 2](zadani-kolo-2.md). Hodnocení kola 2: [postavy a pozadí](hodnoceni-kolo-2.md), tam jsou i zadání pro kolo 3. Hodnocení kola 3: [večerní náměstí a rampa](hodnoceni-kolo-3.md). Části postavy pro animaci: [zadání](zadani-casti.md). Kreslené fáze chůze: [zadání](zadani-faze-chuze.md).

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
| a-namesti_v02.png | ChatGPT (ručně) | zadání `a-namesti` kola 2, předloha stylu ruda-list_v01 | ☑ směr (D32), nahrazeno v03 ([hodnocení](hodnoceni-kolo-2.md)) |
| c-namesti-vecer_v02.png | ChatGPT (ručně) | zadání `c-namesti-vecer` kola 2, stejná konverzace jako náměstí | ☑ směr (D32), nahrazeno v03 |
| a-archiv_v02.png | ChatGPT (ručně) | zadání `a-archiv` kola 2 | ☑ vzor interiérů (D32) |
| a-rampa_v02.png | ChatGPT (ručně) | zadání `a-rampa` kola 2 | ☐ nahrazeno v03 |
| test-postavy-namesti_v02.png | složeno skriptem | ruda/bara-list_v02 na a-namesti_v02 | test |
| test-postavy-archiv_v02.png | složeno skriptem | ruda/bara-list_v02 na a-archiv_v02 | test |
| a-namesti_v03.png | ChatGPT (ručně) | úprava křivosti a-namesti_v02 (zadání v hodnocení kola 2) | ☑ reference exteriérů (D33) ([hodnocení](hodnoceni-kolo-3.md)) |
| c-namesti-vecer_v03.png | ChatGPT (ručně) | stejná úprava ve večerní verzi | ☑ reference exteriérů (D33) |
| test-postavy-namesti-vecer_v03.png | složeno skriptem | ruda/bara-list_v02 na c-namesti-vecer_v03 | test |
| a-rampa_v03.png | ChatGPT (ručně) | zadání rampy v03 z hodnocení kola 2 | ☑ reference staveniště a Archy (D34) ([hodnocení](hodnoceni-kolo-3.md)) |
| test-postavy-rampa_v03.png | složeno skriptem | ruda/bara-list_v02 na a-rampa_v03 | test |
| ruda-casti_v01.png | ChatGPT (ručně) | [zadání částí](zadani-casti.md), průhledné pozadí | ☑ použito pro loutku s klouby (D39) |
| ruda-list_v03.png | ChatGPT (ručně) | list Rudy s průhledným pozadím | ☑ pohledy zepředu, z boku, zezadu ve hře |
| ruda-chuze-bok_v01.png | ChatGPT (ručně) | [zadání fází chůze](zadani-faze-chuze.md), stejná konverzace jako v03 | ☐ zkouška D40 |
| ruda-stoji_v01.png | ChatGPT (ručně) | [zadání stání](zadani-faze-chuze.md), stejná konverzace jako fáze chůze | ☑ pohledy zepředu, z boku, zezadu ve hře (nahrazují v03) |
| ruda-model_v01.png | ChatGPT (ručně) | [animace postav](../animace-postav.md), zadání 0 | ☑ model postavy |
| ruda-chuze-bok_v02.png | ChatGPT (ručně) | zadání 1, 12 fází | nahrazeno v03 (předměty skákaly) |
| ruda-chuze-bok_v03.png | ChatGPT (ručně) | zadání 1b, 12 fází, 1254 × 1254 | ☑ ve hře |
| ruda-chuze-predu_v01.png | ChatGPT (ručně) | zadání 2 | ☑ ve hře |
| ruda-chuze-zezadu_v01.png | ChatGPT (ručně) | zadání 3 | ☑ ve hře |
| ruda-stani_v01.png | ChatGPT (ručně) | zadání 4 | ☐ nahrazeno v02 |
| ruda-stani_v02.png | ChatGPT (ručně) | zadání 4 podle chůze | ☑ ve hře |
| ruda-mluveni_v01.png | ChatGPT (ručně) | zadání 5 | ☐ nahrazeno v02 |
| ruda-mluveni_v02.png | ChatGPT (ručně) | zadání 5 podle chůze | ☑ ve hře |
| ruda-akce_v01.png | ChatGPT (ručně) | zadání 6 | ☐ nahrazeno v02 |
| ruda-akce_v02.png | ChatGPT (ručně) | zadání 6 podle chůze | ☑ ve hře |
| pisma-nahled_v01.png | snímky ze hry (`ladeni.gd pismo=`) | F0/R4 náhled písem: Open Sans, Monkey Island, Patrick Hand, Bangers, Kalam, Comic Neue | ☑ vybráno Patrick Hand (D48) |
| pisma-patrick-ve-hre_v01.png | snímek ze hry | Patrick Hand na celé obrazovce | ☑ ve hře |
