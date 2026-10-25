# Hodnocení vzorků – kolo 1

> 6 vzorků z ChatGPT (ručně), 2026-10-25, zadání z `tools/vzorky/zadani.json`.
> Hodnoceno podle kontrolního seznamu ve [stylové bibli](../../06-stylova-bible.md).

## Celkový verdikt

**Postavy jsou na dobré cestě, pozadí jsou krásná, ale ve špatném stylu.** Pozadí vypadají jako
malovaná fantasy ilustrace (realistické proporce, gotická architektura, tenké nebo žádné linky).
Postavy jsou komiksové s linkou. Ve hře by spolu nefungovaly: postavy by vypadaly nalepené
na cizí obraz. Další kolo má posunout **pozadí blíž k postavám**, ne naopak.

## Kontrolní seznam

| Kritérium | Náměstí A | Archiv A | Rampa A | Náměstí C | Ruda | Bára |
|---|---|---|---|---|---|---|
| paleta odpovídá variantě | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| linka hnědá, proměnlivá, ne černá | ❌ téměř chybí | ❌ | ❌ | ❌ | ✅ | ⚠️ měkčí než u Rudy |
| nic není dokonale rovné | ❌ realistická architektura | ⚠️ | ⚠️ | ❌ | – | – |
| motiv nedokončenosti | ✅ výborný | ⚠️ slabší (stačí) | ✅ výborný | ✅ | – | – |
| kometa na obloze | ✅ | – (interiér) | ✅ | ✅ výrazná | – | – |
| žádný text | ✅ cedule prázdné | ✅ | ✅ | ✅ | ✅ | ✅ |
| žádní lidé v pozadí | ✅ | ✅ | ✅ | ✅ | – | – |
| čitelné zmenšené na mobil | ❌ příliš detailů | ⚠️ | ❌ | ❌ | ✅ | ✅ |
| komiksové proporce | ❌ | ❌ | ❌ | ❌ | ⚠️ hlava malá | ⚠️ hlava malá |
| odpovídá popisu postavy | – | – | – | – | ✅ výborně | ✅ |

## Co funguje

- **Palety A i C** jsou trefené. Teplá rezavá Nedostavěnice i fialovo-oranžový soumrak.
- **Náměstí večer je stejná kompozice jako náměstí ve dne**, jen přebarvená. Pro hru ideální:
  stejné aktivní místa, jen jiná nálada. Tenhle postup (večerní verze ve stejné konverzaci)
  zachovat.
- **Motiv nedokončenosti** (lešení, kužely, pásky, jeřáby, plachty) je silný a vtipný.
- **Prázdné cedule** bez písmen: AI poslechla, nápisy dodá engine v obou jazycích.
- **Ruda** je skoro přesně on: hubený, dlouhý nos, rozcuchané vlasy, samolibý úsměv, červená
  pruhovaná kravata, krátké kalhoty se žlutými ponožkami, desky a hrnek. Pohledy zepředu, z boku
  a zezadu jsou konzistentní (hrnek i desky ve stejných rukou).
- **Bára** má výrazný a od Rudy jasně odlišný obrys (test siluet by prošla), kostým sedí.

## Co nefunguje

1. **Styl pozadí:** malířský realismus místo komiksu. Chybí silná hnědá obrysová linka,
   tvary nejsou přehnané ani zkřivené. Příčina je nejspíš v zadání: „soft painterly shading“
   a „rich cluttered detail“ přebily „thick ink outlines“.
2. **Doba a místo:** gotická radnice, hrady, akvadukty a středomořská krajina působí jako
   fantasy středověk. Naše postavy mají kravatu, tablet a hrnek kávy a Ruda bydlí
   v rozestavěném paneláku. Stylová bible dobu zatím neurčuje, je potřeba ji doplnit.
3. **Moc detailů:** pozadí jsou na hru přeplněná. Na mobilu nebude poznat, co je aktivní místo,
   a postava v popředí zanikne.
4. **Klíčový prvek chybí:** na náměstí není vidět šachta výtahu, která končí v půlce patra.
   Je to součást puzzle i vtipu.
5. **Archa:** na rampě leží dřevěno-plechová loď (Noemova archa). Hezká slovní hříčka, ale
   příběh mluví o startu a vzletu. Je potřeba určit, jak má Archa vypadat.
6. **Proporce postav:** hlavy mají skoro realistickou velikost. Stylová bible chce zhruba čtvrtinu
   až třetinu výšky postavy (jako u Deponie).
7. **Postavy mezi sebou:** Ruda je kreslený roztřesenou tuší, Bára měkčím, „disneyovštějším“
   stylem. Rozdíl je malý, ale v sérii postav by narůstal.

## Návrh úprav pro kolo 2

### Rozhodnutí, která jsou potřeba (doporučení)

- **Doba a místo:** současné zanedbané středoevropské maloměsto. Staré domy se mísí
  s nedostavěnými šedými paneláky, technika z let 1970–2000 (tlačítkové výtahy, telefonní budky,
  starý autobus). Sedí to k českému humoru i k „fázi 2“ a jasně se to odliší od fantasy.
- **Archa:** stará rezavá loď, ke které někdo přidělal raketové motory, křídla a anténu.
  Absurdní, okamžitě čitelné („loď, která má letět“) a v duchu Deponie.

### Změny v zadání

- Odstranit „soft painterly shading“ a „rich cluttered detail“.
- Přidat: `cartoon caricature style of a classic point-and-click comedy adventure, simplified
  shapes, bold thick dark-brown outlines around every object, buildings leaning and bulging
  in different directions, flat colors with simple soft shading, moderate amount of detail`.
- Přidat: `clear open walkable floor in the lower third of the image, main objects large and
  easy to read`.
- Přidat dobu a místo: `contemporary run-down Central European small town, old houses mixed
  with unfinished grey concrete panel blocks`. Vyloučit: `no gothic cathedral, no medieval
  castle, not realistic`.
- Náměstí: `an exterior elevator shaft attached to the facade that visibly stops halfway
  up the second floor`.
- Rampa: popis Archy podle rozhodnutí výše.
- Postavy: `big caricature head, about one third of body height` u Rudy, `about one quarter`
  u Báry. U Báry přidat `same ink line style as the reference image` a nahrát list Rudy jako
  předlohu.

### Nejsilnější trik: Ruda jako předloha stylu

Rudův list stylem sedí nejlépe. V ChatGPT ho nahrajte do konverzace a napište: *„Nakresli pozadí
přesně v tomto kreslířském stylu, se stejnou linkou a barevností: …“* a pak zadání pozadí.
Model se tak chytí stylu postavy a pozadí s postavami sladí. Skript to umí taky (pole
`reference`).
