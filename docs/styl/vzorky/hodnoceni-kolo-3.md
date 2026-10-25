# Hodnocení vzorků – kolo 3

> Večerní náměstí `c-namesti-vecer_v03.png` a `c-namesti-vecer_v03b.png` a rampa `a-rampa_v03.png`
> (ChatGPT, ručně; náměstí jako úprava
> křivosti podle zadání z [hodnocení kola 2](hodnoceni-kolo-2.md)). Pro srovnání i denní
> `a-namesti_v03.png`, ze kterého večerní verze vychází.
> Hodnoceno podle kontrolního seznamu ve [stylové bibli](../../06-stylova-bible.md).

## Pozor: v03b je stejný soubor jako v02

`c-namesti-vecer_v03b.png` je bajt po bajtu shodný s `c-namesti-vecer_v02.png` (stejný kontrolní
součet MD5). Nejspíš se při ukládání stáhl starší obrázek z konverzace. Srovnání je tedy ve
skutečnosti **v02 (rovné) proti v03 (křivé)**. Pokud vznikla ještě jiná varianta, je potřeba ji
uložit znovu.

## Verdikt

**v03 je jasně lepší a doporučuji ho jako novou referenci večerních exteriérů.** Úprava křivosti
se povedla: je to zatím nejblíž Deponii. Denní `a-namesti_v03` se povedl stejně a obě verze
zůstaly ve stejné kompozici.

## Kontrolní seznam

| Kritérium | v02 (= v03b) | v03 |
|---|---|---|
| paleta C | ✅ | ✅ |
| linka hnědá, viditelná | ✅ | ✅ |
| nic není dokonale rovné | ❌ | ✅ budovy se naklánějí, zvlněná střecha, prohnuté sloupy a lešení, nakřivo i panelák |
| žlutá jen pro důležité věci | ❌ žluté plachty | ✅ plachty tyrkysové a okrové |
| drobnosti po okrajích, střed volný | ❌ prázdná dlažba | ✅ bedna s nářadím, kbelík, cihly, hadice |
| klíčové prvky (kabina výtahu, budka, kašna) | ✅ | ✅ |
| stejná kompozice jako denní verze | ✅ (s v02) | ✅ (s v03) |
| kometa | ✅ velká, dominantní | ⚠️ menší než ve v02 |
| volná pochozí plocha | ✅ | ⚠️ podlaha se prohýbá (efekt rybího oka) |
| čitelné zmenšené na mobil | ⚠️ | ⚠️ tmavší, ale okna a lampy vedou oko |

## Co se povedlo

- **Křivost funguje a scéna zůstala čitelná.** Radnice má zvlněnou střechu a prohnuté sloupy,
  lešení se ohýbá, panelák v pozadí se naklání a domky po stranách se opírají jeden o druhý.
  Přesně ten „opilý“ svět, který stylová bible chce.
- **Večerní světlo:** rozsvícená okna, lampa a telefonní budka vytvářejí teplé ostrůvky ve
  fialové scéně. Oko jde přirozeně k důležitým místům.
- Všechny tři opravy z kola 2 jsou splněné: křivost, barva plachet i drobnosti po okrajích.

## Na co dát pozor

1. **Efekt rybího oka.** Model křivost udělal zčásti tak, že ohnul celý obraz, včetně dlažby.
   Deponia ohýbá předměty, ne objektiv. Pro hru je prohnutá podlaha nepříjemná: postavy se
   při chůzi do hloubky zmenšují podle roviny podlahy a na prohnuté dlažbě to bude vypadat
   divně. Pro vertical slice to stačí, u dalších scén přidat do zadání `flat even ground plane,
   no fisheye lens distortion, only the objects are crooked`.
2. **Kometa je menší než ve v02.** U večerních a krizových scén (hlavně kap. 4) má být kometa
   velká, protože se blíží. Velikost komety se bude měnit podle kapitoly. Tuhle verzi lze
   brát jako kapitolu 1–2.
3. **Postavy potřebují v noci barevné ladění.** Test se složenými postavami
   (`test-postavy-namesti-vecer_v03.png`) ukazuje, že denně nasvícení Ruda a Bára ve večerní
   scéně svítí jako vystřižení: bílá košile září do fialového soumraku. Řešení je v enginu:
   postavy se ve scéně tónují barvou jejího světla (večer do fialova a oranžova). Kreslit
   zvlášť noční verze postav není potřeba. Zapsat do produkčních zásad.

## Rozhodnutí (D33)

- ✅ **`a-namesti_v03` a `c-namesti-vecer_v03`** jsou schválené jako nové reference exteriérů
  místo v02.
- ✅ Do šablony pozadí ve stylové bibli i do `tools/vzorky/zadani.json` přibyl pokyn proti
  rybímu oku.
- ✅ Tónování postav podle světla scény a měkký stín pod nohama jsou v produkčních zásadách.
- ✅ Duplicitní `c-namesti-vecer_v03b.png` je smazaný.
- ⏳ Zbývá rampa v03 podle zadání z kola 2 (pokyn proti rybímu oku je v něm doplněný).

## Rampa v03

### Verdikt

**Doporučuji schválit jako referenci.** Všechny výtky z kola 2 jsou opravené a rampa teď
stylem sedí k náměstí v03 i k postavám (ověřeno testem `test-postavy-rampa_v03.png`).

### Kontrolní seznam

| Kritérium | Rampa v02 | Rampa v03 |
|---|---|---|
| paleta A | ✅ | ✅ |
| linka hnědá, viditelná | ⚠️ malířštější | ✅ stejná jako u náměstí v03 |
| rampa je šikmá a míří k obloze | ❌ vodorovná plošina | ✅ jasně šikmá, příď Archy míří nahoru |
| Archa (D29) | ✅ | ✅ konzistentní s v02: rez, záplaty, tři raketové motory, křídla, anténa, mísa |
| město v dálce (D28) | ❌ středomořské | ✅ paneláky, červené střechy, tovární komín; ⚠️ pár štíhlých stromů připomíná cypřiše |
| motiv nedokončenosti | ✅ | ✅ horní konec rampy končí ve vzduchu s bedněním a výztuží |
| rovná podlaha, bez rybího oka | – | ✅ |
| volná pochozí plocha | ✅ | ✅ (spíš prázdná, louže ji oživují) |
| nic není dokonale rovné | ⚠️ | ⚠️ okolí málo křivé |
| žádný text, žádní lidé | ✅ | ✅ |
| sedí k postavám | ⚠️ | ✅ ověřeno |

### Co se povedlo

- **Hned je jasné, kudy Archa poletí:** stojí na kolejovém vozíku přídí nahoru po šikmé rampě.
- **Horní konec rampy končí v půlce ve vzduchu** s bedněním a trčící výztuží. Vtip Nedostavěnice
  i úkol pro hráče v jednom obrázku.
- **Jeřáb je žlutý**, a to je tu správně: v minihře Jeřábový balet (M13) je jediný jeřáb ve městě
  klíčový objekt, takže si výstražnou žlutou zaslouží.
- Archa je stejná jako ve v02, takže se dá považovat za ustálený návrh.

### Na co dát pozor

1. **Okolí je málo křivé** proti náměstí v03. Navrhuji to ale nechat a udělat z toho záměr:
   **rampa je jediná rovná věc ve městě.** Je to stavba světa plánu (přesná, podle výkresů),
   zatímco všechno kolem se kroutí. Bedny, lešení a boudy kolem mohou být křivější; to lze
   dodělat úpravou jako u náměstí, není to nutné.
2. **Pár štíhlých tmavých stromů** vlevo připomíná cypřiše. Drobnost, při finální výrobě opravit.
3. **Míchačka je také žlutá.** Ta důležitá není; při finální výrobě přebarvit (např. oranžová).
4. Archa je vysoko nad pochozí plochou. Pro hru to znamená, že se k ní hráč dostane po žebříku
   nebo lešení; při návrhu kapitoly 2 s tím počítat.

### Rozhodnutí (D34)

- ✅ **`a-rampa_v03`** je schválená jako reference staveniště a ustálený vzhled Archy.
- ✅ **Rampa je schválně jediná rovná stavba ve městě** (symbol světa plánu); zapsáno ve
  stylové bibli a v koncepci Dva světy.
