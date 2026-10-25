# Vyhodnocení technického prototypu „Náměstí“ (K10)

> Odpovědi na otázky O1–O8 z [plánu prototypu](08-prototyp-namesti.md), změřené časy, dopady na
> produkční zásady a stylovou bibli a odhad rozsahu hry.
> Stav: **vyhodnoceno 2026-10-25**, verze 1.0

## Shrnutí

**Technika obstála.** Godot 4.7 + Popochiu 2.2 se pro hru hodí, AI grafika ve hře funguje, oba
jazyky i ovládání prstem na telefonu fungují. Prototyp ale ukázal, že **největší riziko projektu
už není technika, ale rozsah**: obsah (texty v obou jazycích, grafika, minihry) bude stát řádově
stovky hodin. Doporučuji vydat kapitolu 1 jako samostatnou hratelnou ukázku a o rozsahu celé hry
rozhodnout až podle její skutečné pracnosti.

## Co prototyp obsahuje

| Položka | Počet |
|---|---|
| Místnosti | 2 (Náměstí ve dne a večer, Archiv) |
| Aktivní místa | 7 (kašna, budka, dveře, stánek, kometa, schody, kartotéka) |
| Postavy | 2 (Ruda, Pan Změna jako hlas) |
| Předměty a kombinace | 3 předměty, 1 kombinace, 1 použití na scénu |
| Dialogy | 1 se 3 volbami |
| Texty hry | 62 (48 replik), 449 slov česky, 534 anglicky; dalších 19 textů GUI |
| Vlastní skripty hry | 32 |
| Nástroje | 7 (zakládání objektů, ladění se snímky, vyříznutí postav, ikony, rozřez postavy, kontrola textů, HTTPS server) |

## Odpovědi na otázky

| # | Otázka | Odpověď | Podrobnosti |
|---|---|---|---|
| O1 | Hodí se Godot 4 + Popochiu a naše spolupráce? | ✅ **Ano** | Všechny kroky šly udělat. Továrny Popochiu potřebují editor, obešel to nástroj `vytvor` (běží uvnitř hry). Claude zakládá objekty a píše logiku, výsledek si ověřuje snímky; autor ladí v editoru a zkouší myší. Slabiny: šablona GUI počítá s malým písmem (opraveny 4 chyby rozvržení), do webové verze se přibalují skripty editoru (chyby v konzoli, hru neomezují), několik zastaralých funkcí. |
| O2 | Funguje AI grafika ve hře? | ✅ **Ano**, s výhradami | Zmenšování do hloubky, stín a tónování světlem fungují, postavy stylem sedí k pozadí. Výhrady: perspektiva AI pozadí je přehnaná a nekonzistentní (měřítka jsou kompromis); **nevyzkoušeno, jak postava zajde za předmět** (pozadí nemá oddělené popředí). |
| O3 | Dá se Ruda rozhýbat? | ⚠️ **Částečně** | Loutka (pohupování) je pro prototyp přijatelná a autor ji vybral. Rozřezané nohy fungují jen z boku. Pro finální hru je potřeba AI grafika po částech (kostra v Godotu) nebo kreslené fáze. |
| O4 | Fungují dva jazyky? | ✅ **Ano** | Přepínání za běhu, zapamatování volby, výchozí jazyk podle systému, kontrolní skript. Čeština je delší, rozvržení GUI je nutné zkoušet v obou jazycích. |
| O5 | Jde hra ovládat prstem? | ✅ **Ano** | Na telefonu přes prohlížeč funguje chůze, aktivní místa, dialog i lišta. Na dotyku: trvale viditelná lišta, skrytý ukazatel. ❓ Zbývá navrhnout prohlédnutí bez pravého tlačítka (dlouhé podržení, nebo prohlédnutí jako součást klepnutí). |
| O6 | Je webová verze dost malá a rychlá? | ⚠️ **Na Wi-Fi ano** | 48 MB (WebAssembly Godotu 38 MB + hra 8,7 MB), na Wi-Fi se načte rychle a běží plynule. Na mobilních datech je to hodně: hosting musí komprimovat (gzip/brotli, zhruba čtvrtina). **Godot na webu vyžaduje HTTPS.** Každá další kapitola přidá hlavně grafiku (asi 3–4 MB na scénu ve dne a večer). |
| O7 | Jaký poměr stran? | ⚠️ **3:2 zatím stačí** | Na telefonu na šířku jsou po stranách tmavé pruhy. Doporučení pro finální hru: pozadí širší (19,5:9), důležitý obsah uprostřed v pásu 3:2, okraje jen dokreslují scénu. |
| O8 | Kolik času stojí výroba? | 📏 **Změřeno** | Viz níže. |

## Změřené časy (O8)

Čas od commitu předchozího kroku do commitu kroku, včetně autorova zkoušení v editoru:

| Krok | Obsah | Čas |
|---|---|---|
| K0 | instalace, projekt, průvodce | ~25 min |
| K1 | místnost, chůze, hloubka, stín + nástroje | 20 min |
| K2 | 3 aktivní místa, tabulka textů | 22 min |
| K3 | postava, dialog se 3 volbami, předmět | 30 min |
| K4 | 2 předměty, kombinace, použití na scénu | 21 min |
| K5 | druhá místnost, přechody | 22 min |
| K6 | přepínač jazyka, kontrola překladů | 17 min |
| K7 | den a večer, tónování | 14 min |
| K8 | export, HTTPS, dotyk (vč. stažení 1,3 GB šablon) | 32 min |
| K9 | chůze dvěma metodami | ~15 min |
| **Celkem** | | **≈ 3,5 hodiny** |

Grafika k prototypu (styl, 3 kola vzorků, 13 obrázků) trvala dalších asi 2,5 hodiny včetně hodnocení.

**Orientační jednotky práce** (po zaběhnutí nástrojů, bez grafiky):

| Jednotka | Čas |
|---|---|
| místnost s pochozí plochou a 3–5 aktivními místy | 20–30 min |
| dialog s větvemi a 10–20 replikami v obou jazycích | 30–60 min |
| předmět s kombinací nebo použitím | 10–20 min |
| pozadí přes AI (2–3 kola, den + večer) | 30–60 min |
| referenční list postavy přes AI | 20–40 min |
| minihra (odhad, v prototypu nebyla) | 4–10 h |

Nejvíc času nezabírá kód, ale **psaní vtipných textů ve dvou jazycích, výroba grafiky a ladění
detailů rozhraní**. Kód díky nástrojům rychle zlevňuje, texty a grafika ne.

## Odhad rozsahu

**Kapitola 1** (podle [návrhu](kapitoly/01-iniciace.md): 6 scén, 9 postav, ~15 předmětů,
3 minihry, 350–450 replik na jazyk):

| Část | Odhad |
|---|---|
| místnosti, aktivní místa, puzzly, dialogy (kód) | 12–20 h |
| texty: 350–450 replik v obou jazycích, vtipy, úpravy | 15–25 h |
| grafika: 6 pozadí × den/večer, 9 referenčních listů, ikony | 10–15 h |
| 3 minihry (návrh, papírový prototyp, výroba) | 15–30 h |
| animace postav (části nebo fáze) | 5–10 h |
| testování a ladění (autor) | 10–15 h |
| **Celkem** | **≈ 70–115 h** |

**Celá hra** (prolog + 5 kapitol, kapitoly 2–3 větší, 14 miniher): zhruba **6–8× kapitola 1,
tedy 450–900 hodin**. Při 5–8 hodinách týdně je to 1,5–3 roky.

## Doporučení

1. ✅ **Vydat kapitolu 1 jako samostatnou ukázku** (zdarma, web + PC; schváleno jako D38). Ověří zájem hráčů, zábavnost
   i skutečnou pracnost. Teprve potom rozhodnout o rozsahu dalších kapitol.
2. **Zúžit rozsah celé hry**, pokud se odhad potvrdí: cíl 4–6 hodin místo 8–12, minihry z 14 na
   8–10 (vynechat nejméně nosné, např. M05 a M12), kapitoly 2 a 3 sloučit, nebo zkrátit.
3. **Před výrobou grafiky kapitoly 1** rozhodnout poměr stran (širší pozadí) a vyzkoušet postavu za
   předmětem (vrstva popředí), aby se pozadí nemusela generovat dvakrát.
4. **Animace:** do vertical slice stačí loutka; souběžně zkusit AI grafiku Rudy po částech pro kostru.
5. **Minihry otestovat nejdřív na papíře** (M13 a M14 podle plánu), protože jsou nejdražší částí.

## Co se změnilo v ostatních dokumentech

- [Produkční zásady](05-produkce.md): Godot a Popochiu v praxi, web a HTTPS, dotyk, poměr stran,
  texty a import, rozhraní ve dvou jazycích, animace, nástroje.
- [Stylová bible](06-stylova-bible.md): pokyn pro věrohodnou perspektivu, vrstva popředí, pruh 3:2.
- [Záznam rozhodnutí](00-rozhodnuti.md): D36 (chůze loutkou), D37 (prototyp obstál).
