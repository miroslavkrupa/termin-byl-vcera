# Zadání: kreslené fáze chůze

> ⚠️ Nahrazeno dokumentem [Animace postav](../animace-postav.md) (D41). Ponecháno jako záznam zkoušky.

> Chůze jako v klasických kreslených adventurách: každá fáze kroku je samostatný obrázek celé postavy
> a hra je přehrává za sebou (animace snímek po snímku). Nahrazuje loutku s klouby, pokud bude
> výsledek konzistentní (D40). Začínáme zkouškou jedné sady (chůze bokem); když obstojí,
> doplní se chůze dopředu, dozadu, stání a mluvení.

## Proč všechny fáze najednou

AI kreslí každý obrázek trochu jinak (kravata, ruce, hrnek). Když vzniknou všechny fáze v jednom
obrázku, drží se mezi sebou mnohem víc. Nástroj je pak rozřeže a zarovná na stejnou výšku a polohu.

## Postup v ChatGPT

1. Nová konverzace, nahraj **`docs/styl/vzorky/ruda-list_v03.png`**.
2. Vlož zadání níže (formát na šířku 3:2).
3. Zkontroluj: **8 postav ve 2 řadách po 4**, všechny **stejně velké**, žádné se nedotýkají,
   **průhledné pozadí**, žádná čísla ani podložka. Pokud ne, napiš co opravit, např.
   *„All eight figures must be exactly the same height and must not touch each other.“*
4. Ulož jako **`docs/styl/vzorky/ruda-chuze-bok_v01.png`**.

## Zadání: chůze bokem

```
Using the attached character reference sheet, draw a walk cycle animation sheet of this same character in side view, walking to the right.
8 frames arranged in two rows of four, read left to right, top row first. Every frame shows the whole character at exactly the same size, with the feet on the same baseline, evenly spaced, none touching.
Classic hand-drawn 2D point-and-click adventure animation with lively, exaggerated cartoon motion and clear key poses: 1 contact (right leg forward), 2 down, 3 passing, 4 up, 5 contact (left leg forward), 6 down, 7 passing, 8 up.
Knees bend, arms swing opposite to the legs, the body bobs up and down, the hair and tie bounce slightly. He keeps holding the coffee mug in his far hand and the clipboard in his near hand in every frame.
Exactly match the drawing style, line work, colors, clothes and proportions of the reference in every frame.
Transparent background, no ground, no shadows, no text, no numbers.
```

## Stání ve stejném stylu jako chůze

Pohledy z listu v03 jsou štíhlejší, mají menší hlavu a jiné stínování než fáze chůze. Proto se
**fáze chůze stávají hlavní předlohou** a stání se kreslí podle nich. Pokračuj ve stejné konverzaci
jako fáze chůze, výsledek ulož jako **`docs/styl/vzorky/ruda-stoji_v01.png`**.

```
Now draw the same character exactly as in the walk cycle from your last image, standing still in three views on one sheet: front view, side view facing right, back view, left to right, evenly spaced, not touching.
Same height, same head size, same body proportions, same line work, same shading and colors as the walk cycle frames. Relaxed neutral standing pose, holding the coffee mug and the clipboard as in the walk cycle.
Transparent background, no ground, no shadows, no text, no numbers.
```

### Stání v2: stejné proporce jako chůze

`ruda-stoji_v01` sedí stylem, ale ne proporcemi: hlava je vůči tělu menší (asi 31 % výšky postavy,
ve fázích chůze 36 %) a tělo štíhlejší. Ve hře je proto Ruda po zastavení buď vyšší, nebo má menší
hlavu. Pokračuj ve stejné konverzaci, výsledek ulož jako **`docs/styl/vzorky/ruda-stoji_v02.png`**.

```
Redraw the three standing views (front, side facing right, back) at exactly the same scale and proportions as the walk cycle frames: the head must be as large relative to the body as in the walk frames (about one third of the total height), the same body width, the same leg length and the same shoe size. Compare with the passing frame of the walk cycle: standing should be only slightly taller than that frame.
Same line work, shading and colors. Transparent background, no ground, no shadows, no text.
```

## Později (když zkouška obstojí)

- **Chůze dopředu:** totéž, „walking toward the viewer, front view“ (předloha: fáze chůze bokem).
- **Chůze dozadu:** „walking away from the viewer, back view“.
- **Stání:** 4 fáze jemného dýchání a přešlapování.
- **Mluvení:** 4–6 fází s pohybem úst a gestem volné ruky.

## Co se stane potom

Nástroj `hra/nastroje/sestav_faze.gd` list rozřeže, fáze zarovná (chodidla na stejnou čáru, hlava
a trup na stejnou svislici) a uloží do `hra/grafika/postavy/ruda_chuze_bok/`. Hra je pak přehrává
v rytmu ušlé vzdálenosti, takže nohy neklouzají. Doleva se postava zrcadlí.
