# Zadání pro kolo 2

> Vygenerováno z `tools/vzorky/zadani.json` (kolo 2). Změny proti kolu 1 vycházejí z
> [hodnocení kola 1](hodnoceni-kolo-1.md): komiksový styl místo malby, silná hnědá linka, méně
> detailů, současné středoevropské maloměsto (D28), Archa jako rezavá loď s raketovými motory (D29)
> a Rudův list jako předloha stylu.

## Postup v ChatGPT

1. Generuj v tomto pořadí: nejdřív Ruda, pak ostatní. ✅ Kroky 1 a 2 jsou hotové (`ruda-list_v02`, `bara-list_v02`,
   [hodnocení](hodnoceni-kolo-2.md)); pozadí (kroky 3–6) generuj s předlohou `ruda-list_v02.png`.
2. U každého kroku nahraj do konverzace uvedený obrázek (ikona sponky) a vlož celé zadání.
3. Výsledek ulož do `docs/styl/vzorky/` jako `<id>_v02.png` (další pokus `_v03`).
4. Úpravy piš klidně česky („silnější hnědé linky“, „méně detailů“, „odstraň Rudu z obrázku“).

## 1. `ruda-list`: Ruda s větší hlavou

Nová konverzace. Nahraj `ruda-list_v01.png`.

```
Generate a landscape image, aspect ratio 3:2.
full-body character turnaround sheet, front view, side view and back view of the same character,
the same character as in the reference image, keep his face, hair, clothes, clipboard and coffee mug, but make his head a big caricature head, about one third of his body height: lanky overconfident project manager in his forties, long pointy nose, messy spiky dark hair, smug grin, loose red striped tie, wrinkled off-white shirt with rolled-up sleeves, too-short grey-blue trousers showing yellow socks, long thin limbs,
warm muted palette of ochre, rust and faded teal with yellow construction accents,
classic point-and-click comedy adventure caricature style, exaggerated cartoon proportions, bold thick dark-brown ink outlines with varying line weight, flat colors with soft cel shading, neutral standing pose, plain white background, no text, no letters
```

## 2. `bara-list`: Bára ve stylu Rudy

Nová konverzace. Nahraj `ruda-list_v01.png` jako předlohu stylu.

```
Generate a landscape image, aspect ratio 3:2.
Match the drawing style, line work and coloring of the reference image exactly, but do not include the character from it,
full-body character turnaround sheet, front view, side view and back view of the same character,
a different character: practical young engineer woman, compact sturdy build, clearly shorter than average, big caricature head about one quarter of her body height, short red bob haircut, round glasses, teal work overalls over a rust-red shirt, measuring tape clipped to a pocket, holding a tablet, calm skeptical expression,
warm muted palette of ochre, rust and faded teal with yellow construction accents,
classic point-and-click comedy adventure caricature style, exaggerated cartoon proportions, bold thick dark-brown ink outlines with varying line weight, flat colors with soft cel shading, neutral standing pose, plain white background, no text, no letters
```

## 3. `a-namesti`: Náměstí (varianta A)

Nová konverzace. Nahraj `ruda-list_v02.png` jako předlohu stylu.

```
Generate a landscape image, aspect ratio 3:2.
Match the drawing style, line work and coloring of the reference image exactly, but do not include the character from it,
2D cartoon background for a classic point-and-click comedy adventure game, caricature style,
small town square in front of a crooked half-finished 1970s town hall wrapped in scaffolding, an exterior elevator shaft attached to the facade that visibly stops halfway up the second floor, an unfinished grey concrete panel block in the background, a dry fountain in the middle, a market stall with blank signs, an old phone booth, a few traffic cones and warning tape, a comet with a long glowing tail in the hazy sky,
warm muted palette of ochre, rust and faded teal with yellow construction accents,
contemporary run-down Central European small town setting, simplified exaggerated shapes, buildings leaning and bulging in different directions, nothing is straight, bold thick dark-brown outlines around every object, flat colors with simple soft shading and subtle hand-painted texture, moderate amount of detail, clear open walkable floor in the lower third of the image, main objects large and easy to read, not realistic, no gothic architecture, no medieval castles, no text, no letters, no logos, no people
```

## 4. `c-namesti-vecer`: Náměstí večer (varianta C)

**Stejná konverzace jako náměstí**, aby kompozice zůstala stejná.

```
Generate a landscape image, aspect ratio 3:2.
Now draw the same square as in the previous image, same composition, at dusk.
Match the drawing style, line work and coloring of the reference image exactly, but do not include the character from it,
2D cartoon background for a classic point-and-click comedy adventure game, caricature style,
the same small town square at dusk: crooked half-finished 1970s town hall wrapped in scaffolding, exterior elevator shaft stopping halfway up the second floor, unfinished grey concrete panel block in the background, dry fountain, market stall, old phone booth, warm light in a few windows, long shadows, a large glowing comet with a long tail dominating the sky,
dramatic dusk palette, purple and deep blue sky, orange glow from the comet, strong contrast,
contemporary run-down Central European small town setting, simplified exaggerated shapes, buildings leaning and bulging in different directions, nothing is straight, bold thick dark-brown outlines around every object, flat colors with simple soft shading and subtle hand-painted texture, moderate amount of detail, clear open walkable floor in the lower third of the image, main objects large and easy to read, not realistic, no gothic architecture, no medieval castles, no text, no letters, no logos, no people
```

## 5. `a-archiv`: Archiv (varianta A)

Nová konverzace. Nahraj `ruda-list_v02.png` jako předlohu stylu.

```
Generate a landscape image, aspect ratio 3:2.
Match the drawing style, line work and coloring of the reference image exactly, but do not include the character from it,
2D cartoon background for a classic point-and-click comedy adventure game, caricature style,
basement archive of failed projects under the town hall, crooked metal and wooden shelves full of dusty boxes and binders leaning in different directions, old index card cabinets, a desk with a green lamp and an old rotary phone, flickering fluorescent tubes on the low ceiling, interior scene,
warm muted palette of ochre, rust and faded teal with yellow construction accents,
contemporary run-down Central European small town setting, simplified exaggerated shapes, buildings leaning and bulging in different directions, nothing is straight, bold thick dark-brown outlines around every object, flat colors with simple soft shading and subtle hand-painted texture, moderate amount of detail, clear open walkable floor in the lower third of the image, main objects large and easy to read, not realistic, no gothic architecture, no medieval castles, no text, no letters, no logos, no people
```

## 6. `a-rampa`: Rampa s Archou (varianta A)

Nová konverzace. Nahraj `ruda-list_v02.png` jako předlohu stylu.

```
Generate a landscape image, aspect ratio 3:2.
Match the drawing style, line work and coloring of the reference image exactly, but do not include the character from it,
2D cartoon background for a classic point-and-click comedy adventure game, caricature style,
construction site of a huge concrete launch ramp outside town, half-poured segments with wooden formwork, one old crane, a cement mixer; on the ramp lies the Ark: a big rusty old ship hull with improvised rocket engines bolted to the stern, makeshift wings and a radio antenna, patched with tarps; unfinished panel blocks of the town in the distance, a comet with a long glowing tail in the hazy sky,
warm muted palette of ochre, rust and faded teal with yellow construction accents,
contemporary run-down Central European small town setting, simplified exaggerated shapes, buildings leaning and bulging in different directions, nothing is straight, bold thick dark-brown outlines around every object, flat colors with simple soft shading and subtle hand-painted texture, moderate amount of detail, clear open walkable floor in the lower third of the image, main objects large and easy to read, not realistic, no gothic architecture, no medieval castles, no text, no letters, no logos, no people
```
