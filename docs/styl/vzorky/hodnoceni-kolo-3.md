# Hodnocení vzorků – kolo 3

> Večerní náměstí: `c-namesti-vecer_v03.png` a `c-namesti-vecer_v03b.png` (ChatGPT, ručně, úprava
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
