# Zadání: části postavy pro animaci

> Ruda (a později další postavy) rozdělený na části, ze kterých se v Godotu složí loutka s klouby
> (kostra). Chůze pak má ohýbaná kolena a houpající se ruce, ne jen pohupování celého obrázku.
> Zadání odpovídá vzorku `ruda-casti` v `tools/vzorky/zadani.json`.

## Postup v ChatGPT

1. Nová konverzace, nahraj **`docs/styl/vzorky/ruda-list_v02.png`** (ikona sponky).
2. Vlož zadání níže.
3. **Zkontroluj průhledné pozadí.** ChatGPT umí PNG s průhledným pozadím. Pokud vrátí bílé nebo
   kostičkované pozadí nakreslené do obrázku, napiš: *„Make the background truly transparent
   (PNG with alpha channel), not white and not a checkerboard pattern.“*
4. Zkontroluj, že se **žádné dvě části nedotýkají** a že na obrázku **nejsou popisky ani čísla**.
   Kdyby ano, napiš: *„Move the parts further apart so none of them touch, and remove all text.“*
5. Ulož jako **`docs/styl/vzorky/ruda-casti_v01.png`**.

Průhledné pozadí řeší i bílá místa mezi vlasy: postavu pak není potřeba vyřezávat z bílé a hrany
jsou čisté (pixel perfect).

## Zadání

```
Using the attached character reference sheet, draw the same character as separate body parts for 2D cutout animation (like a paper puppet), side view facing right, exactly matching the drawing style, line work, colors and proportions of the reference.
The parts:
1. head with neck and hair
2. torso with shirt, loose red striped tie and belt, without arms and without legs, ending at the hips
3. upper arm with rolled-up shirt sleeve, shoulder to elbow
4. forearm with hand holding the coffee mug, elbow to hand
5. forearm with hand holding the clipboard, elbow to hand
6. thigh in grey-blue trousers, hip to knee
7. lower leg in grey-blue trousers ending with a yellow sock, knee to ankle
8. brown shoe in side view
Each part separate with generous empty space around it, nothing overlapping, nothing touching. Every joint end drawn complete and rounded like a puppet joint, so the parts can overlap and rotate without gaps. Same scale for all parts. Transparent background, no text, no labels, no numbers, no shadows.
```

## Co se stane potom

Nástroj `hra/nastroje/rozdel_casti.gd` list rozdělí na samostatné obrázky (podle průhlednosti)
a Claude z nich složí kostru s klouby (rameno, loket, kyčel, koleno, kotník) a animaci chůze,
stání a mluvení. Jedna stehenní, lýtková a botová část poslouží pro obě nohy, jedna paže pro obě ruce.
