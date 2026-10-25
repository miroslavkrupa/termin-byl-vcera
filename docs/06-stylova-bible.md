# Stylová bible

> Jak má hra vypadat. Zadání pro AI dnes a pro ilustrátora později: kdo obrázek vyrábí, musí
> podle tohoto dokumentu trefit stejný styl.
> Stav: **schváleno** (D21): varianta A jako hlavní styl, C pro večerní a krizové scény, verze 0.2

## Směr: ručně malovaná komiksová 2D adventura

Inspirací je *Deponia* (D20). Nekopírujeme ji, přebíráme vlastnosti jejího vizuálu a přenášíme je
do našeho světa: místo planety ze šrotu je tu město věčných staveb, lešení a jeřábů.

### Co dělá vizuál Deponie a co si bereme

| Vlastnost | Jak ji použijeme my |
|---|---|
| ručně kreslené, digitálně malované pozadí | malované pozadí s viditelným tahem štětce, žádné 3D ani pixel art |
| výrazná tmavá obrysová linka s proměnlivou tloušťkou | tmavě hnědá (ne černá) linka, silnější na obrysech, tenčí uvnitř |
| přehnané proporce postav | velké hlavy, dlouhé končetiny, výrazné nosy a ruce |
| přeplněné, detailní prostředí | každá scéna plná rozestavěných věcí, lešení, cedulí, provizorií |
| nic není rovné | budovy se kroutí, perspektiva je mírně opilá, lešení se prohýbá |
| teplá zemitá paleta s barevnými akcenty | rez, okr, vybledlá tyrkysová; akcenty ve žluté výstražné barvě stavby |
| hloubka vzduchem | vzdálené plány světlejší a modřejší, popředí tmavé a sytější |
| komiksová mimika | velké oči a obočí, výrazy čitelné i na mobilu |

### Náš vlastní podpis

- **Motiv nedokončenosti:** lešení, jeřáby, výstražné pásky, cedule „Fáze 2“, kužely, plachty.
  Je to vizuální vtip, který nese téma hry.
- **Kometa Deadline** je na obloze v každé venkovní scéně a s postupem hry se zvětšuje.
  Hráč tak vidí čas bez jakéhokoli ukazatele.
- **Žlutá výstražná barva** stavby je vyhrazená pro důležité věci (aktivní předměty, akcenty,
  Archa). Nepoužívat ji na nedůležité pozadí.

## Pravidla

### Linka
- Barva obrysu: tmavě hnědá až skoro černá, nikdy čistě černá.
- Tloušťka: vnější obrys postav 2–3× silnější než vnitřní kresba. Pozadí tenčí linka než postavy,
  aby postavy vystupovaly.
- Linka mírně roztřesená, ručně kreslená. Žádné dokonale rovné vektorové čáry.

### Barvy
- Paleta podle schválené varianty (viz níže), 5–7 základních barev scény + akcent.
- Postavy sytější a kontrastnější než pozadí, aby byly čitelné.
- Aktivní místa se nesmějí poznávat jen podle barvy (přístupnost); hra má tlačítko
  „ukaž aktivní místa“.

### Proporce postav
- Hlava zhruba 1/4 výšky postavy (komiksové zkreslení), u Rudy ještě o kus větší.
- Siluety musí být rozpoznatelné i jako černý stín: každá hlavní postava má jiný tvar
  (Ruda dlouhý a hubený, Bára menší a pevná, Předseda široký a hranatý).

### Prostředí
- Rozlišení scén 1920 × 1080, scény mohou být širší kvůli posouvání.
- Vrstvy: pozadí, střední plán, pochozí plocha, popředí (pro parallax a překrývání postav).
- Žádný text v obrázcích. Cedule mají prázdné plochy, nápisy dodá engine v obou jazycích.
- Na mobilu musí být důležité objekty čitelné: nic důležitého menšího než zhruba 48 px v plném rozlišení.

### Animace
- Postavy po částech (hlava, trup, ruce, nohy) pro kostrovou animaci.
- Výrazy tváře jako samostatné vrstvy (5–8 výrazů na hlavní postavu).

## Tři varianty ke schválení

Všechny tři dodržují pravidla výše, liší se paletou, náladou a sytostí. Vizuální porovnání je
v [ukázkách](styl/ukazky.html) (otevři v prohlížeči).

| | A: Rezavá Nedostavěnice | B: Slunné lešení | C: Soumrak termínu |
|---|---|---|---|
| **Nálada** | nejblíž Deponii: zaprášená, teplá, trochu zchátralá | veselejší, světlejší, rodinná | dramatická, večerní, kometa svítí |
| **Paleta** | okr, rez, vybledlá tyrkysová, olivová | sytá modrá obloha, terakota, svěží zelená | fialová, oranžová, tmavě modrá |
| **Kontrast** | střední | nízký až střední | vysoký |
| **Riziko** | při špatném zpracování může působit špinavě | méně osobitá, blíž běžným mobilním hrám | těžší čitelnost v tmavých scénách a na mobilu |
| **Rozhodnutí** | ✅ hlavní styl | – | ✅ večerní a krizové scény (kap. 4) |

✅ **Schváleno (D21): A jako hlavní styl, C pro večerní a krizové scény.** Kapitola 4 tak bude
vizuálně temnější, aniž by se změnil styl. Varianta B se nepoužívá.

### Kdy použít paletu C
- večerní a noční scény v kterékoli kapitole,
- krizové scény, hlavně celá kapitola 4 a řídicí věž,
- přechod mezi A a C může být plynulý (soumrak) a sám o sobě signalizovat, že se blíží potíže.

## Výroba obrázků přes AI

### Zásady
- **Nikdy nejmenovat cizí hru, studio ani výtvarníky v zadání.** Popisujeme vlastnosti stylu.
  Je to fér vůči autorům, bezpečnější z hlediska autorských práv a výsledek je víc náš.
- Nejdřív **referenční listy postav** (zepředu, z boku, zezadu, výrazy). Teprve s nimi
  generovat scény s postavami. Bez listů nebudou postavy konzistentní.
- Pozadí generovat **bez postav**. Postavy se vkládají v enginu.
- Každý vygenerovaný obrázek projde ruční úpravou: srovnat paletu, sjednotit linku, odstranit
  nesmysly (AI ráda přidá text, prsty navíc, nelogickou architekturu).
- Zaznamenat nástroj a zadání u každého finálního obrázku (Steam vyžaduje uvést použití AI).

### Šablona zadání: pozadí (varianta A)

```
2D hand-painted cartoon background for a point-and-click adventure game,
absurd ramshackle town where every building is unfinished: scaffolding, cranes,
half-built bridge, tarps, traffic cones, warning tape,
crooked exaggerated perspective, nothing is straight,
warm muted palette of ochre, rust and faded teal with yellow construction accents,
thick dark-brown ink outlines with varying line weight, soft painterly shading,
rich cluttered detail, atmospheric haze in the distance,
a comet with a long glowing tail in the hazy sky,
no text, no letters, no people, 16:9
```

### Šablona zadání: referenční list postavy (Ruda)

```
full-body character turnaround sheet, front view, side view and back view,
lanky overconfident project manager in his forties, oversized head,
long pointy nose, messy spiky dark hair, smug grin, loose striped tie,
wrinkled shirt with rolled-up sleeves, too-short trousers, clipboard and coffee mug,
exaggerated cartoon proportions, head about one third of body height, long thin limbs,
thick dark-brown ink outlines with varying line weight, flat colors with soft cel shading,
neutral standing pose, plain white background, no text
```

Pro další varianty se mění jen řádek s paletou:
- **B:** `bright cheerful palette, saturated blue sky, terracotta, fresh green, sunny light`
- **C:** `dramatic dusk palette, purple and deep blue sky, orange glow from the comet, strong contrast`

## Další postup

1. ~~Vybrat variantu~~ ✅ A + C (D21).
2. Podle šablon nech vygenerovat 2–3 pozadí ve variantě A, jedno večerní ve variantě C
   a referenční list Rudy. Ulož je do `docs/styl/vzorky/`.
3. Společně je porovnáme s pravidly výše a doladíme zadání. Schválené vzorky se stanou
   referencí pro všechny další obrázky.

## Kontrolní seznam pro každý obrázek

- [ ] paleta odpovídá variantě
- [ ] linka hnědá, proměnlivá, ne čistě černá
- [ ] nic není dokonale rovné
- [ ] motiv nedokončenosti je ve scéně přítomný
- [ ] kometa na obloze (venkovní scény) ve velikosti podle kapitoly
- [ ] žádný text
- [ ] důležité objekty čitelné i zmenšené na mobil
- [ ] postava odpovídá referenčnímu listu
