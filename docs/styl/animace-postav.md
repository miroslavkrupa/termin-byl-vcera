# Animace postav: model a zadání

> Jak vyrobit animace postav přes ChatGPT tak, aby k sobě všechny seděly. Platí pro Rudu i další
> postavy (D41). Nahrazuje dílčí zadání [fází chůze](vzorky/zadani-faze-chuze.md).
> Stav: **schváleno**, verze 1.0

## Princip

1. **Model postavy** (stání zepředu, z boku, zezadu) ve finálních proporcích je jediná předloha.
   Vzniká jako první a všechny animace se kreslí podle něj.
2. **Každá animace je samostatný obrázek** s fázemi v mřížce. Ne všechno najednou: v jednom obrázku
   by byla postava malá a rozmazaná a jedna chyba by znamenala začít znovu.
3. **Všechno ve stejné konverzaci ChatGPT.** Když se konverzace hodně protáhne (desítky obrázků),
   začni novou a nahraj do ní model.
4. **Ke každému zadání se připojí stejná pravidla** (níže). Hlídají to, co se zatím pokazilo:
   prohozené předměty mezi rukama, jiná velikost hlavy, jiné proporce.
5. **Jen animace, které hra opravdu potřebuje.** Skok, montáž a podobně až u scény, která je vyžaduje.

## Pravidla (připojit za každé zadání)

```
RULES: Draw exactly the same character as the model sheet earlier in this conversation. Same scale and proportions in every frame: the head is about one third of the total height, same body width, same leg length, same shoe size as the model sheet.
The props never switch hands: the coffee mug is always in the hand farther from the viewer and the clipboard always in the hand closer to the viewer, held the same way in every frame. In front view the mug is on the viewer's left and the clipboard on the viewer's right.
All frames in an even grid, read left to right and top to bottom, the feet of every frame on that row's baseline, figures never touching or overlapping.
Same line work, shading and colors as the model sheet. Transparent background, no ground, no shadows, no text, no numbers, no frame borders.
```

## Zadání

Všechny obrázky jsou na šířku (3:2). Ukládej do `docs/styl/vzorky/` jako `<postava>-<animace>_v01.png`,
další pokus `_v02`.

### 0. Model postavy (`ruda-model_v01.png`)

```
Draw the model sheet of this character: standing still in three views, front view, side view facing right, back view, left to right. Relaxed neutral pose, holding the coffee mug and the clipboard. Use exactly the proportions of the walk cycle frames from earlier in this conversation: head about one third of the total height, the same body width, leg length and shoe size.
```
+ pravidla

### 1. Chůze bokem, 12 fází (`ruda-chuze-bok_v02.png`)

```
Draw a walk cycle of this character in side view walking to the right: 12 frames in 3 rows of 4.
Frames 1-6 are one step with the near leg: 1 contact (near leg forward, heel touching), 2 down, 3 early passing, 4 passing, 5 up, 6 reaching forward. Frames 7-12 are the same step with the far leg.
Classic hand-drawn 2D adventure game animation: lively, slightly exaggerated, knees bend, arms swing opposite to the legs, hair and tie bounce a little. The head moves up and down only slightly, keep it at almost the same height in all frames.
```
+ pravidla

### 2. Chůze k divákovi, 8 fází (`ruda-chuze-predu_v01.png`)

```
Draw a walk cycle of this character in front view walking toward the viewer, walking in place (the figure does not get bigger or move): 8 frames in 2 rows of 4. Frames 1-4 one step with his right leg, frames 5-8 with his left leg: contact, down, passing, up. Arms swing slightly, the head stays at almost the same height.
```
+ pravidla

### 3. Chůze od diváka, 8 fází (`ruda-chuze-zezadu_v01.png`)

```
Draw a walk cycle of this character in back view walking away from the viewer, walking in place (the figure does not get smaller or move): 8 frames in 2 rows of 4. Frames 1-4 one step with his right leg, frames 5-8 with his left leg: contact, down, passing, up. Arms swing slightly, the head stays at almost the same height.
```
+ pravidla

### 4. Stání, 2 × 4 fáze (`ruda-stani_v01.png`)

```
Draw an idle animation of this character standing still: 2 rows of 4 frames. Top row: side view facing right; bottom row: front view. A slow subtle loop: breathing, a small shift of weight, one blink, a tiny sip of coffee in one frame. The feet stay in place.
```
+ pravidla

### 5. Mluvení, 2 × 6 fází (`ruda-mluveni_v01.png`)

```
Draw a talking animation of this character: 2 rows of 6 frames. Top row: side view facing right; bottom row: front view. Different mouth shapes in each frame (closed, open, wide, round), lively eyebrows, and a self-confident gesture with the hand holding the mug. The feet stay in place.
```
+ pravidla

### 6. Sebrání a použití, 2 × 6 fází (`ruda-akce_v01.png`)

```
Draw two short actions of this character in side view facing right: 2 rows of 6 frames.
Top row: picking something up from the ground: he tucks the clipboard under his near arm, bends down, picks up a small object with the near hand and straightens up.
Bottom row: using something at hand height in front of him: he tucks the clipboard under his near arm, reaches forward with the near hand, does a short twisting motion and pulls the hand back.
The feet stay in place.
```
+ pravidla (u této animace se desky smí přesunout pod paži, jak říká zadání)

## Kontrola každého obrázku

- [ ] správný počet fází a mřížka, žádné dvě postavy se nedotýkají
- [ ] průhledné pozadí (na zeleném podkladu bez bílého lemu)
- [ ] hrnek i desky jsou ve všech fázích ve stejné ruce
- [ ] velikost hlavy a proporce jako na modelu
- [ ] žádná čísla, popisky ani podložka

Když něco nesedí, oprav to ve stejné konverzaci jednou větou, například:
*„In frames 3 to 6 the mug and the clipboard switched hands. Redraw the whole sheet with the mug always in the hand farther from the viewer.“*

## Zpracování (Claude)

1. `hra/nastroje/rozdel_casti.gd` rozřeže obrázek na fáze (po řádcích, zleva doprava).
2. `hra/nastroje/sestav_faze.gd` je zarovná (chodidla na jednu čáru, trup na jednu svislici)
   a u chůze změří krok, aby nohy neklouzaly.
3. Fáze se uloží do `hra/grafika/postavy/<postava>_<animace>/` a zapojí do hry.

Dnes je ve hře zapojená chůze bokem a stání. Ostatní animace se zapojí, jakmile budou obrázky.
