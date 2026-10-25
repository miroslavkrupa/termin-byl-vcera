# ☄️ Termín byl včera

*Komediální point & click adventura o projektovém manažerovi, který musí poprvé v životě něco dokončit.*

Sebestředný projektový manažer **Ruda Gantt** musí dokončit Archu dřív, než na město Nedostavěnice,
kde nebylo nikdy nic dokončeno, dopadne kometa **Deadline**. Hra je ve stylu *Deponie*: sarkastický
antihrdina, absurdní svět, fér puzzly a rozhodnutí, která se vracejí o kapitoly později.
Archa se skládá z částí různé povahy: některé potřebují plán, jiné zkoušení s lidmi. Ruda
zosobňuje svět plánu, parťačka Bára svět iterací a uspějí, až se naučí spolupracovat.
Mimochodem a nenásilně učí projektové řízení – iniciaci, plánování, Scrum, řízení rizik a změn,
komunikaci se stakeholdery – a to mechanikami a minihrami, ne přednáškami.

Hra je pro **co nejširší publikum** milovníků adventur a vzniká **v angličtině i češtině zároveň**
(anglicky pracovně *Deadline Was Yesterday*). Bude **zdarma** s možností dobrovolného příspěvku,
pro **PC, Mac a mobily**.

> Stav: **návrh** (pracovní název, žádný kód zatím neexistuje)

## Návrhová dokumentace

| Dokument | Obsah |
|---|---|
| [Záznam rozhodnutí](docs/00-rozhodnuti.md) | co bylo rozhodnuto, kdy a co z toho plyne |
| [Koncepce: Dva světy, jedna Archa](docs/07-dva-svety.md) | jednotící myšlenka: hybridní řízení jako páteř hry, čtyři patra, postavy jako dva světy, metodický oblouk, konce |
| [Vize](docs/01-vize.md) | návrh na jednu stránku: pilíře, cílová skupina, co si hráč odnese, co hra není |
| [Výuková matice](docs/02-vyukova-matice.md) | PM témata → kapitola → mechanika → důkaz pochopení; pokrytí domén PMBOK |
| [Příběhová bible](docs/03-pribehova-bible.md) | svět, postavy, dějový oblouk, osnova kapitol, stavové proměnné, následky, konce |
| [Minihry](docs/04-minihry.md) | 14 miniher ve čtyřech patrech koncepce, zásady, specifikace, pořadí prototypů, šablona |
| [Produkce](docs/05-produkce.md) | rozsah pro jednoho autora, platformy a ovládání, příspěvky, AI grafika, příprava na dabing, jazyky |
| [Stylová bible](docs/06-stylova-bible.md) | výtvarný styl podobný Deponii, pravidla, schválená varianta A (večer a krize C), zadání pro AI |
| [Stylové ukázky](docs/styl/ukazky.html) | vizuální porovnání variant (otevřít v prohlížeči) |
| [Kapitola 1: Iniciace](docs/kapitoly/01-iniciace.md) | vertical slice: scény, puzzly, graf závislostí, rozhodnutí, minihry, ukázkové dialogy CS/EN |

## Postup návrhu

1. **Vize** – schválit pilíře a rozhodnout otevřené otázky (cílová skupina, platforma, grafika)
2. **Výuková matice** – doplnit a uzamknout témata
3. **Příběhová bible** – dopsat osnovu kapitol a postavy
4. **Systém rozhodnutí** – tabulka stavů a flagů (zatím součást příběhové bible)
5. **Graf závislostí puzzlů** pro každou kapitolu
6. **Papírové prototypy miniher**, playtest na 3–5 lidech
7. **Vertical slice** – kapitola 1 hratelná naplno (30–45 min)
8. **Výroba po kapitolách** – každá kapitola jako release s playtestem a retrospektivou

## Technologie (návrh)

Godot 4 + Popochiu (framework pro point & click adventury), dialogy v Ink nebo Dialogue Manageru,
texty v tabulkách řetězců. Godot exportuje na Windows, macOS, Android, iOS i do prohlížeče.
❓ Ověřit dotykové ovládání v Popochiu.
