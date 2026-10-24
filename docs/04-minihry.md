# Seznam miniher

> Každá minihra nese jedno nebo dvě výuková témata (odkaz na ID z [výukové matice](02-vyukova-matice.md))
> a je zakotvená v příběhu. Před výrobou musí projít papírovým prototypem.
> Stav: **koncept**, verze 0.1

## Zásady

1. **Délka 5–10 minut.** Minihra je koření, ne hlavní jídlo.
2. **Vždy v příběhu.** Nikdy „teď si zahrajeme hru o WBS“, vždy „slon blokuje bránu hangáru“.
3. **Výsledek není jen výhra/prohra.** Kvalita výsledku se propisuje do stavových proměnných
   a do příběhu.
4. **Vždy přeskočitelná, ale hrát se vyplatí.** Kdo minihru přeskočí, pokračuje s horším
   výsledkem v příběhu, nikdy neuvízne. Kdo ji hraje, dostane navíc: lepší výsledek, vtipy a scény,
   které jinde nejsou, repliky do souboje argumenty, předměty usnadňující pozdější puzzly a úspěchy
   (achievementy).
5. **Bez textových lekcí.** Pojem se odemkne v Deníku až po dohrání.
6. **Papírový prototyp první.** Kartičky a kostky na stole, 3–5 testerů, teprve potom kód.
7. **Zábavná i bez znalosti PM.** Pravidla se musí dát pochopit ze scény. V rozhraní minihry
   nejsou odborné pojmy (ne „WBS“, ale „porcování slona“). Testovat i na hráčích, kteří o PM nic neví.
8. **Bez jazykových hříček v pravidlech.** Minihra musí fungovat stejně v angličtině i češtině.
9. **Hratelná myší i prstem.** Žádné ovládání závislé na najetí myší, dost velké prvky na dotyk.

## Přehled

| # | Minihra | Metoda | Kap. | Témata | Priorita pro vertical slice | Stav |
|---|---|---|---|---|---|---|
| M01 | Charter z trosek | project charter | 1 | V02, V03 | ⭐ vysoká | nápad |
| M02 | Kdo tu vlastně velí | mapa stakeholderů | 1 | V04 | ⭐ vysoká | nápad |
| M03 | Souboj argumenty | komunikace se stakeholdery | 1–4 | V05 | ⭐ vysoká | nápad |
| M04 | Jak sníst slona | WBS | 2 | V06 | střední | nápad |
| M05 | Poker s goblinem | planning poker | 2 | V07 | střední | nápad |
| M06 | Mapa do neznáma | roadmapa, plánování po vlnách | 2 | V08 | střední | nápad |
| M07 | Krabice od bot | registr rizik | 2 | V09 | střední | nápad |
| M08 | Tetris kapacity | sprint planning | 3 | V12 | nízká | nápad |
| M09 | Standup za 15 minut | daily scrum | 3 | V13 | nízká | nápad |
| M10 | Scope Creep | řízení změn | 3 | V15 | nízká | nápad |
| M11 | Plachetnice | retrospektiva | 3–4 | V19 | nízká | nápad |
| M12 | Dashboard lží | měření, earned value | 4 | V17 | nízká | nápad |

Vertical slice doporučuji postavit na kapitole 1: M01, M02 a M03 v ní pokrývají iniciaci
a ověří nejdůležitější a nejrizikovější minihru (souboj argumenty), která se táhne celou hrou.

## Specifikace

### M01 Charter z trosek
- **Příběh:** původní charter Archy se rozpadl na útržky. Sponzor, Pan Změna a Komise do něj
  podstrkují své nesmysly.
- **Mechanika:** skládání listiny ze střípků do kolonek (cíl, rozsah, mimo rozsah, kritéria úspěchu,
  sponzor, rozpočet, termín). Část útržků jsou nesmysly („cíl: aby to bylo hezký“) nebo nejsou
  měřitelné.
- **Výsledek:** kvalita charteru ovlivní důvěru stakeholderů a dostupné argumenty v kap. 4.
- **Riziko návrhu:** může působit jako formulář → potřebuje silný humor v útržcích.

### M02 Kdo tu vlastně velí
- **Příběh:** Ruda musí zjistit, koho přesvědčit, aby se stavba vůbec rozjela.
- **Mechanika:** postavy (i ty, které hráč potkal jen mimochodem) se umísťují do mřížky
  vliv × zájem. Některé vlastnosti zná hráč jen tehdy, když s postavou mluvil. Babičku odhalí
  jen hráč, který dával pozor.
- **Výsledek:** odemkne strategie dialogu a rozhodnutí R1.2.
- **Riziko návrhu:** „správné“ umístění musí jít odvodit ze hry, ne z teorie.

### M03 Souboj argumenty
- **Příběh:** opakující se střet se stakeholdery (Komise, sponzor, Pan Změna, finále s Předsedou).
- **Mechanika:** obdoba šermování urážkami z *Monkey Islandu*. Druhá strana vznese námitku, hráč
  odpoví replikou. Repliky se sbírají během hry: z charteru, z dat, z rozhovorů s týmem.
  Lež a nereálný slib vyhrají kolo, ale později se vrátí.
- **Výsledek:** důvěra stakeholderů, přístup k dalším lokacím, rozhodující souboj v kap. 4.
- **Riziko návrhu:** nejsložitější na psaní, potřebuje hodně kvalitních a vtipných replik.

### M04 Jak sníst slona
- **Příběh:** obří slon (ztělesnění „celé Archy“) blokuje bránu hangáru.
- **Mechanika:** hráč porcuje slona na kusy a ty na menší kusy, až jsou zvládnutelné.
  Chybějící kus (mezera) nebo kus porcovaný dvakrát (překryv) se vrátí jako problém.
- **Výsledek:** kvalita WBS ovlivní kapacitu a počet překvapení v kap. 3.

### M05 Poker s goblinem
- **Příběh:** v hospodě U Odhadu se o odhadech sází.
- **Mechanika:** relativní odhady úkolů kartami. Goblini podvádějí: kotví („tohle jsou dva dny,
  ne?“), předhánějí se v optimismu, skupinové myšlení.
- **Výsledek:** přesnost odhadů ovlivní realističnost roadmapy.

### M06 Mapa do neznáma
- **Příběh:** cesta materiálu ke stavbě vede přes Mlžnou pláň.
- **Mechanika:** kreslení trasy po mapě. Blízká krajina je vidět ostře, vzdálená v mlze. Kdo kreslí
  detail do mlhy, musí ho při odhalení překreslovat. Mlha se po etapách zvedá.
- **Výsledek:** naučí plánování po vlnách; ovlivní čas.

### M07 Krabice od bot
- **Příběh:** Ruda dostane krabici od bot jako „registr rizik“.
- **Mechanika:** ve scénách se hledají podezřelé věci (stopy krys, prasklé lano, podezřelý
  Předsedův úsměv) a zapisují se s reakcí. Rozpočet nestačí na všechno, takže je nutné vybírat.
- **Výsledek:** zapsaná rizika se později vyplácejí (kočka Riziková, rozhodnutí R2.3).

### M08 Tetris kapacity
- **Příběh:** plánování každého sprintu stavby.
- **Mechanika:** úkoly různých tvarů se skládají do kapacity sprintu; závislosti spojují dílky.
  Přeplněný sprint přetéká a zvyšuje technický dluh.
- **Výsledek:** rychlost, technický dluh, morálka.

### M09 Standup za 15 minut
- **Příběh:** ranní porada týmu u hangáru.
- **Mechanika:** časovaný dialog. Členové týmu odbočují, hráč odbočky ukončuje a vybírá, kterou
  překážku řešit hned po poradě.
- **Výsledek:** morálka a odstraněné překážky.

### M10 Scope Creep
- **Příběh:** tvor, který roste s každou neřízenou změnou.
- **Mechanika:** každý změnový požadavek se dá přijmout, odmítnout, nebo vyměnit za něco
  (trade-off). Odmítat všechno sníží důvěru stakeholderů, přijímat všechno nechá tvora vyrůst.
- **Výsledek:** velikost tvora (rozsah, čas), důvěra stakeholderů.

### M11 Plachetnice
- **Příběh:** tým se na konci sprintu sejde na lodičce v přístavu.
- **Mechanika:** k lodi se umísťují kotvy (co nás brzdí), vítr (co pomáhá) a útesy (rizika).
  Na závěr hráč vybere jedno konkrétní zlepšení, které platí v další kapitole.
- **Výsledek:** zlepšení kapacity nebo morálky a odemčené možnosti v dalších scénách.

### M12 Dashboard lží
- **Příběh:** řídicí věž hlásí, že je vše zelené. Kometa se přitom blíží.
- **Mechanika:** porovnávání ukazatelů s realitou ve scéně. Hráč odhaluje melounové ukazatele
  (venku zelené, uvnitř červené) a skládá poctivý report (plán vs. skutečnost vs. hodnota).
- **Výsledek:** podklad pro eskalaci R4.1.

## Šablona pro novou minihru

```markdown
### Mxx Název
- **Příběh:** proč se to děje ve hře
- **Mechanika:** co hráč dělá, jaká jsou pravidla
- **Výsledek:** co se propíše do proměnných a do příběhu
- **Témata:** ID z výukové matice
- **Riziko návrhu:** co se může pokazit (nuda, nejasnost, náročnost výroby)
- **Papírový prototyp:** jak ho rychle otestovat
```

## Otevřené otázky

- [ ] Jedna minihra opakovaná víckrát (souboj argumenty), nebo každá jen jednou?
- [ ] Obtížnost miniher: jedna úroveň, nebo volitelná?
- [ ] Mají mít minihry vlastní vizuální styl, nebo zůstat ve stylu scén?
