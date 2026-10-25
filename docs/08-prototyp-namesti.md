# Technický prototyp „Náměstí“

> Funkční základ hry z grafiky, kterou už máme. Ověří techniku dřív, než vyrobíme další grafiku
> a obsah kapitoly 1 (D35).
> Stav: **plán**, verze 0.1

## Proč

Výtvarný styl je ustálený, ale největší nejistoty jsou teď technické. Prototyp je má zodpovědět
co nejlevněji. Teprve podle výsledku se rozhodne, v jakém formátu vyrábět další grafiku a jak
velká hra se dá reálně udělat.

## Otázky, na které má prototyp odpovědět

| # | Otázka | Kdy je odpověď „ano“ |
|---|---|---|
| O1 | Hodí se Godot 4 + Popochiu pro tuto hru a pro naši spolupráci (Claude píše kód, autor ladí v editoru)? | všechny kroky K1–K8 jdou udělat bez obcházení Popochiu |
| O2 | Funguje AI grafika ve hře (vrstvy, zmenšování do hloubky, stín, tónování)? | Ruda na náměstí nepůsobí nalepeně ve dne ani večer |
| O3 | Dá se Ruda rozhýbat? | aspoň jedna metoda chůze (K9) vypadá ve stylu hry přijatelně |
| O4 | Fungují dva jazyky v praxi? | přepnutí CZ/EN za běhu, kontrola chybějících překladů |
| O5 | Jde hra ovládat prstem na mobilu? | prototyp v mobilním prohlížeči jde dohrát bez myši |
| O6 | Je verze do prohlížeče dost malá a rychlá? | načtení do ~10 s, plynulý chod na běžném telefonu |
| O7 | Jaký poměr stran? AI generuje 3:2 (1536 × 1024), monitory jsou 16:9, telefony ještě širší | rozhodnuto podle zkoušky na monitoru i telefonu |
| O8 | Kolik času stojí výroba? | změřené časy pro scénu, aktivní místo, dialog a předmět |

## Rozsah

**Uvnitř:**
- místnost **Náměstí** (`a-namesti_v03`, večer `c-namesti-vecer_v03`) a místnost **Archiv** (`a-archiv_v02`);
- **Ruda** jako hratelná postava (zatím statický obrázek z listu v02, chůze až v K9);
- 3–4 aktivní místa, krátký dialog, inventář se dvěma předměty a jedno kombinování;
- přechod mezi místnostmi, přepínání jazyka a dne/večera;
- verze do prohlížeče.

**Mimo:** minihry, ukládání hry, menu, zvuk a hudba, další postavy (Pan Změna jen jako hlas zpoza
stánku, Lumír vůbec), finální ikony předmětů (zástupné obrázky stačí).

## Technické volby

| Volba | Rozhodnutí | Poznámka |
|---|---|---|
| Engine | **Godot 4.7.x** (standardní verze, ne .NET) | aktuální stabilní řada |
| Adventurní nadstavba | **Popochiu 2.2.x** | cílí na Godot 4.7; dotykové ovládání je zatím označené jako experimentální, proto ho testujeme brzy |
| Jazyk kódu | GDScript | |
| Ovládací šablona Popochiu | **Simple Click** (jedno kliknutí = interakce, prohlédnout druhým tlačítkem / dlouhým stiskem) | nejlepší pro dotyk; slovesa ve stylu SCUMM se na mobilu ovládají špatně |
| Umístění | složka `hra/` v tomto repozitáři | dokumentace a hra pohromadě |
| Grafika | kopie schválených vzorků v `hra/`, Ruda vyříznutý do PNG s průhledností | originály zůstávají v `docs/styl/vzorky/` |
| Texty | tabulka řetězců CSV (`id`, `cs`, `en`, `mluvci`, `emoce`, `poznamka`) | podle produkčních zásad |

## Kroky

Každý krok končí něčím, co jde spustit a vyzkoušet. Ke každému se zapíše, kolik času zabral (O8).

| Krok | Co | Kdo | Hotovo, když |
|---|---|---|---|
| **K0** | Instalace Godotu, stažení Popochiu, založení projektu, zapnutí pluginu a průvodce nastavením | autor instaluje a kliká v editoru, Claude připraví soubory a navede | prázdný projekt s Popochiu se spustí ✅ hotovo |
| **K1** | Místnost Náměstí: pozadí, pochozí plocha, Ruda chodí kliknutím/klepnutím, zmenšuje se do hloubky, má stín | Claude kód a scény, autor doladí polygon pochozí plochy v editoru | Ruda dojde kamkoli na dlažbu a nevyjde mimo | ✅ hotovo (viz Průběh) |
| **K2** | Aktivní místa: kašna (prohlédnout), telefonní budka (použít), dveře radnice (zatím zamčené) | Claude | popisky a reakce v obou jazycích | ✅ hotovo |
| **K3** | Dialog se stánkem Pana Změny (hlas zpoza stánku), dvě volby, jedna z nich dá propisku | Claude | dialog proběhne v CZ i EN |
| **K4** | Inventář: hrnek kávy + propiska → **kávové pero** | Claude, zástupné ikony | kombinování funguje a pero jde použít na Pana Změnu |
| **K5** | Přechod do Archivu dveřmi radnice a zpět, v archivu jedno aktivní místo (kartotéka) | Claude, autor doladí pochozí plochu | přechod oběma směry, Ruda se objeví u dveří |
| **K6** | Jazyky: přepínač CZ/EN za běhu, kontrolní skript na chybějící překlady | Claude | přepnutí bez restartu, skript hlásí chyby |
| **K7** | Večer: přepínač den/večer, tónování Rudy barvou světla scény, stín | Claude | Ruda večer nepůsobí vystřiženě (porovnat s testem z kola 3) |
| **K8** | Export do prohlížeče a zkouška na telefonu | Claude export, autor zkouší na telefonu | odpovědi na O5, O6, O7 |
| **K9** | Zkouška animace Rudy: a) kostrová animace z rozřezaného listu, b) záložní „loutka“ (pohupování a posun) | Claude, případně nové AI obrázky částí těla | vybraná metoda chůze (O3) |
| **K10** | Vyhodnocení: odpovědi na O1–O8, úpravy produkčních zásad a stylové bible, odhad rozsahu hry | Claude a autor | zapsáno, rozhodnuto o dalším postupu |

Souběžně s K1–K8 může autor udělat **papírový prototyp miniher M13 a M14** (kartičky připraví
Claude).

## Průběh

### K0 – projekt (hotovo)

Godot 4.7.2 a Popochiu 2.2.1, šablona Simple Click ve vysokém rozlišení, 1536 × 1024.

### K1 – Náměstí a chůze (hotovo)

- Místnost Náměstí s pozadím `a-namesti_v03`, pochozí plocha po dlažbě (kašna, budka, patníky
  a lavička jsou překážky), oblast zmenšování do hloubky, Ruda jako hráčova postava se stínem.
- Ruda chodí, zmenšuje se do hloubky a ke kašně se nedostane, zastaví se u okraje.
  Při chůzi se přepne na pohled z boku (doleva zrcadlově), když stojí, je vidět zepředu.
- **Nástroj `nastroje/vytvor.gd`** zakládá místnosti, postavy, předměty, pochozí plochy, aktivní
  místa, oblasti a kulisy z příkazové řádky, stejnými továrnami jako panel Popochiu. Claude tak
  nepotřebuje editor ani na zakládání objektů (odpověď na O1 je zatím „ano“).
- **Nástroj `nastroje/ladeni.gd`** spustí hru, pošle postavu na místo a uloží snímek obrazovky.
  Claude si tak výsledek ověří sám.

**Poznatky:**
1. **Perspektiva AI pozadí je přehnaná a nekonzistentní.** Zmenšování nastavené podle telefonní
   budky a patníků (0,17 vzadu, 0,46 vpředu) je kompromis. Dveře radnice by chtěly Rudu ještě menšího.
   Do zadání dalších pozadí přidat „consistent believable perspective“.
2. **Popochiu čte skutečnou pozici kurzoru**, ne souřadnice simulovaného kliknutí. Automatický
   test klikání proto nejde; ověřuje se přes `dojdi` a ručně (autor v editoru, F5), na telefonu v K8.
3. **Statický obrázek při chůzi „klouže“.** Čeká se na K9 (animace).
4. Bílý lem u konečků vlasů po vyříznutí je ve hře téměř neviditelný.

### K2 – aktivní místa (hotovo)

- Kašna, telefonní budka a dveře radnice: popisek při najetí, klepnutí = použít, pravé tlačítko
  = prohlédnout. Ruda dojde na místo, otočí se a promluví.
- **Tabulka řetězců `hra/texty/texty.csv`** (sloupce `keys`, `cs`, `en`, `_mluvci`, `_emoce`,
  `_poznamka`; sloupce s podtržítkem Godot při importu vynechá). Popochiu texty replik i popisků
  překládá samo, ve skriptech jsou jen ID řetězců. Tím je hotová i část kroku K6.
- Nástroj na zakládání objektů teď běží uvnitř spuštěné hry (`godot --headless --path hra --
  vytvor …`), protože skripty místností používají globální objekty Popochiu (C, E, R…).
- Ladicí pomocník umí `akce=<AktivniMisto>:pouzit|prohlednout` a `jazyk=en`.

**Poznatky:**
1. **Písmo šablony bylo na mobil malé** (Open Sans 20 při rozlišení 1536 × 1024). Zvětšeno na 36
   a replikám přidán tmavě hnědý obrys; na světlém pozadí jsou teď čitelné.
2. **Písmo zatím není ve stylu hry.** Open Sans je neutrální; stylová bible typografii zatím
   neřeší. Potřeba vybrat komiksové písmo s úplnou češtinou (licence OFL) a dát Rudovi vlastní
   barvu textu. Ověřit na telefonu v K8.
3. Šablona přidala pixelové písmo „Monkey Island 1991“, které nepoužíváme.
4. **Popisek objektu byl useknutý** (zjistil autor při zkoušce v editoru): rámeček u spodního
   okraje měl jen 35 px a po zvětšení písma se spodek ořízl. Rámeček je teď 80 px vysoký a 30 px
   nad okrajem obrazovky. Popisek ale překrývá postavu, když stojí vpředu; zvážit popisek u kurzoru
   nebo nahoře (rozhodnout po zkoušce na telefonu v K8).

## Rizika prototypu

| Riziko | Dopad | Co s tím |
|---|---|---|
| Dotyk v Popochiu je experimentální | ovládání na mobilu nefunguje dobře | testovat už v K1 v mobilním prohlížeči, ne až v K8 |
| Popochiu vyžaduje hodně práce v editoru | Claude nemůže editor ovládat | rozdělení práce: Claude kód a textové scény, autor polygony a kontrolu v editoru |
| AI kresba nejde rozhýbat | postavy budou strnulé | K9 se dvěma metodami; v nejhorším případě úprava stylové bible (méně animace, víc mimiky) |
| Verze do prohlížeče je velká | dlouhé načítání na mobilu | komprese obrázků při importu, případně menší rozlišení pro web |
| Repozitář je soukromý | GitHub Pages ze soukromého repozitáře vyžaduje placený účet | pro zkoušku na telefonu stačí lokální server ve stejné Wi-Fi; o zveřejnění se rozhodne později |

## Záložní plán

Pokud prototyp ukáže, že Popochiu nebo Godot nevyhovují (O1), přejde se na čistě webovou hru.
Grafika, texty i tabulka řetězců zůstanou použitelné.
