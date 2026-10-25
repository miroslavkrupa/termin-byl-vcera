# Produkční a technické zásady

> Jak hru vyrábět, aby šla hrát na všech platformách, v obou jazycích a aby šla později vyměnit
> grafika a přidat dabing bez přepisování hry.
> Stav: **koncept**, verze 0.1

## Rozsah pro jednoho autora

- Hru dělá jeden autor bez rozpočtu. Cíl 8–12 hodin je horní mez, ne slib.
- **Nejdřív vertical slice** (kapitola 1, 30–45 min). Teprve podle skutečné rychlosti výroby
  se rozhodne o rozsahu dalších kapitol.
- **Vydávat po kapitolách.** Každá kapitola je samostatné vydání zdarma. Hráči dávají zpětnou
  vazbu průběžně a projekt nevisí na jednom velkém dokončení.
- Když se nestíhá, škrtá se šíře (vedlejší linky, počet miniher), ne kvalita hlavní linky a humoru.

## Platformy a ovládání

| Platforma | Export z Godotu | Poznámka |
|---|---|---|
| Windows | ano | |
| macOS | ano | podpis a notarizace aplikace vyžadují účet Apple Developer |
| Android | ano | Google Play: jednorázový registrační poplatek |
| iOS | ano | vyžaduje Mac, Xcode a placený účet Apple Developer (roční poplatek) |
| Prohlížeč | ano | levná cesta, jak hru dostat i na mobily bez obchodů; ověřit výkon v mobilním Safari |

✅ Rozhodnuto (D18): začínáme PC, Macem, Androidem a webovou verzí, iOS se přidá později.
❓ Před vydáním ověřit aktuální poplatky a podmínky obchodů.

**Ovládání musí fungovat myší i dotykem:**
- Nic nesmí záviset na najetí myší (hover). Na mobilu se popisky objektů ukazují klepnutím,
  případně tlačítkem „ukaž aktivní místa“, které je užitečné i na PC.
- Aktivní místa a ovládací prvky dost velké na prst, minihry hratelné jedním prstem.
- Rozhraní čitelné na malém displeji: velikost písma titulků nastavitelná.
- ❓ Ověřit, jak Popochiu podporuje dotykové ovládání; případně doplnit vlastní vrstvu.

## Příspěvky (donate)

⏸️ Zatím se neřeší (D19). Přehled níže je podklad pro rozhodnutí před prvním vydáním.

| Kanál | Možnost příspěvku | Poznámka |
|---|---|---|
| itch.io | přímo u hry zdarma (zaplať, kolik chceš) | nejjednodušší |
| Steam | hra zdarma nemůže přímo přijímat příspěvky | obvyklé řešení: placené DLC „balíček podporovatele“ (soundtrack, artbook) |
| Google Play / App Store | nákup v aplikaci (tip) | obchod si bere provizi |
| Vlastní web | Ko-fi, GitHub Sponsors apod. | odkaz z menu hry; ❓ ověřit, co v tom dovolují pravidla obchodů |

❓ Pravidla platforem se mění, ověřit před vydáním.

## Grafika přes AI s pozdější výměnou

Cíl: kdykoli vyměnit obrázky za ručně kreslené bez zásahu do logiky hry.

- **[Stylová bible](06-stylova-bible.md):** paleta, tloušťka linek, osvětlení, proporce postav,
  ukázkové obrázky. Je to zadání pro AI dnes i pro ilustrátora později.
- **Referenční listy postav:** každá postava zepředu, z boku a zezadu, s výrazy tváře. Hlavní
  problém AI grafiky je nekonzistence postav, listy ji drží.
- **Logika scén oddělená od obrázků:** aktivní místa, pochozí plochy, vrstvy popředí a pozadí
  jsou v enginu jako polygony a body, ne „nakreslené v obrázku“. Výměna pozadí znamená jen
  výměnu souboru.
- **Pevná pravidla pro soubory:** jednotné rozlišení scén (např. 1920 × 1080), pevné pojmenování
  (`ch1_radnice_bg.png`, `ch1_radnice_fg.png`), stejné kotevní body postav.
- **Postavy po částech** (hlava, trup, končetiny) pro kostrovou animaci. Výměna kresby nemění animace.
- **Žádný text v obrázcích.** Nápisy ve scénách jsou samostatné vrstvy z tabulek řetězců,
  jinak by se musely kreslit dvakrát (EN + CS).
- U každého obrázku zaznamenat, jak vznikl (nástroj, zadání). Steam vyžaduje uvést použití AI
  na stránce hry.

## Postavy ve scéně (engine)

Postavy jsou nakreslené jednou, v denním světle. Do scény je usazuje engine (D33):

- **Měkký stín pod nohama.** Bez něj postavy působí nalepeně (ověřeno testem v
  `styl/vzorky/test-postavy-namesti_v02.png`). Stín je eliptický, poloprůhledný a kreslí ho engine,
  ne obrázek postavy.
- **Tónování podle světla scény.** Každá scéna (nebo část scény) má barvu světla; postava se jí
  přizpůsobí násobením barvy a mírným ztmavením. Ve dne skoro neutrální, večer a v krizi
  (paleta C) do fialova s oranžovými odlesky. Bez tónování denně nasvícené postavy ve večerní
  scéně svítí jako vystřižené (`styl/vzorky/test-postavy-namesti-vecer_v03.png`).
- **Světelné zóny.** Kde je ve scéně výrazný zdroj světla (lampa, rozsvícená okna, telefonní
  budka), může se tónování měnit podle toho, kde postava stojí. Pro vertical slice stačí jedna
  barva na scénu.
- **Zmenšování do hloubky** podle roviny podlahy. Proto pozadí nesmějí mít prohnutou podlahu
  (pravidlo „křiví se předměty, ne objektiv“ ve stylové bibli).
- Noční verze postav se nekreslí. Výjimkou mohou být jednotlivé speciální scény.

## Příprava na dabing

- Každá replika má **stabilní ID** (`ch1_bara_012`), které se nemění ani při úpravě textu.
- U každé repliky je **mluvčí, emoce a poznámka pro herce** (např. `[sarkasticky]`), i když se
  zatím nedabuje.
- Zvukové soubory se později pojmenují podle ID a jazyka (`cs/ch1_bara_012.ogg`,
  `en/ch1_bara_012.ogg`). Engine si repliku najde sám, a když chybí, zobrazí jen titulek.
- **Titulky vždy**, i s dabingem.
- Repliky raději kratší. Dlouhé monology se špatně dabují i čtou na mobilu.
- Načasování scén nesmí záviset na délce zvuku. Když dabing chybí, délka se odvodí z textu.

## Jazyky v praxi

- Všechny texty v tabulkách řetězců (CSV nebo formát Godotu), sloupce `id`, `cs`, `en`,
  `mluvci`, `emoce`, `poznamka`.
- **Nová replika bez obou jazyků se nepřijímá.** Kontrolní skript při sestavení hlásí
  chybějící překlady.
- Dialogy v Ink nebo Dialogue Manageru s odkazy na ID řetězců.
- Jazyk se dá přepnout kdykoli v menu, i uprostřed hry.
- Testovat rozvržení s delší verzí textu. Čeština a angličtina mají různou délku slov.

## Verze a zálohy

- Git (již založený), velké soubory grafiky a zvuku přes Git LFS, až budou potřeba.
- Každé vydání kapitoly = značka (tag) v gitu.
