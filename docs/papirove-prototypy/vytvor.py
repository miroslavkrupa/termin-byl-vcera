# Vytvoří tiskový balíček papírových zkoušek miniher kapitoly 1 (F1): kapitola-1.html.
# Spuštění: python3 docs/papirove-prototypy/vytvor.py, pak PDF tiskem z prohlížeče
# (nebo Chrome --headless --print-to-pdf). Karty jsou česky, čísla karet se míchají pevným
# semínkem, aby z čísla nešlo poznat, která karta je správná.
import html, os
E=html.escape
CSS="""
@page{size:A4;margin:10mm}
*{box-sizing:border-box}
body{font-family:'Patrick Hand','Comic Neue',sans-serif;color:#2b1d14;margin:0}
@font-face{font-family:'Patrick Hand';src:url('../../hra/grafika/pisma/PatrickHand-Regular.ttf')}
h1{font-size:28pt;margin:0 0 4mm}
h2{font-size:20pt;margin:6mm 0 2mm;border-bottom:1px solid #b9a27d}
h3{font-size:15pt;margin:4mm 0 1mm}
p,li,td{font-size:12.5pt;line-height:1.3}
.strana{page-break-after:always}
.karty{display:grid;grid-template-columns:repeat(3,63mm);grid-auto-rows:88mm;gap:0;justify-content:center}
.karta{border:1px dashed #9c8a6a;padding:5mm;display:flex;flex-direction:column;position:relative;overflow:hidden}
.karta .druh{font-size:10pt;text-transform:uppercase;letter-spacing:.06em;color:#8a6a40}
.karta .text{font-size:15pt;line-height:1.25;margin-top:3mm;flex:1;display:flex;align-items:center}
.karta .zdroj{font-size:10pt;color:#7a6a55;margin-top:2mm}
.karta.namitka{background:#fbeee2}
.karta.replika{background:#eef3f6}
.karta.utrzek{background:#fdf8e6;transform:rotate(0deg)}
.karta.postava{background:#f1f5ea}
.karta.stopa{background:#f6eef6}
.karta .cislo{position:absolute;right:4mm;bottom:3mm;font-size:9pt;color:#9c8a6a}
table{border-collapse:collapse;width:100%}
td,th{border:1px solid #b9a27d;padding:2mm 3mm;vertical-align:top;text-align:left;font-size:12pt}
th{background:#f3e7d3}
.deska td{height:38mm}
.mrizka{display:grid;grid-template-columns:14mm 1fr 1fr;grid-template-rows:1fr 1fr 14mm;height:250mm;gap:0}
.mrizka .pole{border:2px solid #8a6a40;padding:4mm;font-size:16pt;color:#8a6a40}
.osa{display:flex;align-items:center;justify-content:center;font-size:13pt;color:#5a4630}
.osa.svisla{writing-mode:vertical-rl;transform:rotate(180deg)}
.zeton{display:inline-block;width:22mm;height:22mm;border:1px dashed #9c8a6a;border-radius:50%;margin:2mm;text-align:center;line-height:22mm;font-size:13pt;background:#fde3c8}
.mala{font-size:10.5pt;color:#6a5a45}
"""
# ---------- M03 ----------
NAMITKY=[
 ("Lidi chtějí výsledky, ne papíry!",),
 ("Archa musí být největší v kraji!",),
 ("Minule to taky nevyšlo.",),
 ("Kdo za to ponese odpovědnost?",),
 ("Kolik to bude stát?",),
 ("Noviny chtějí přestřihnout pásku. Kdy?",),
]
DOBRE=[
 ("Proto na jeden papír napíšeme, jaký výsledek chtějí.","z rozhovoru s Pembokem"),
 ("Podle původního zadání má odvézt všechny obyvatele. Velikost z toho vyplyne.","z archivu: původní zadání"),
 ("Minule se nikdo nezeptal rybářů. My se zeptáme.","z archivu: karta poučení"),
 ("Vy za to proč, já za to jak.","od Báry"),
 ("Řeknu vám to, až budeme vědět, co přesně stavíme. Proto ten papír.","od Báry"),
 ("Pásku přestřihnete 30. den při startu. Do té doby vám každý týden ukážu, co je hotové.","z rozhovoru s vrátným"),
]
RYCHLE=[
 ("Výsledky budou do pátku.",""),
 ("Bude největší na světě.",""),
 ("Minule jsem tu nebyl já.",""),
 ("Já za všechno!",""),
 ("Skoro nic. Vlastně nám ještě zbude.",""),
 ("Pásku můžete stříhat hned zítra.",""),
]
SPATNE=[
 ("Pojďme to ozávorkovat a vrátit se k tomu v příštím kvartálu.","Rudův slovník frází"),
 ("Synergie!","Rudův slovník frází"),
 ("Mám na to Ganttův diagram. I na snídani.","Rudův slovník frází"),
]
import random
REPLIKY=DOBRE+RYCHLE+SPATNE
PORADI_K=list(range(len(REPLIKY))); random.Random(7).shuffle(PORADI_K)
K={orig: f"K{pos+1}" for pos,orig in enumerate(PORADI_K)}   # původní index -> číslo karty
# ---------- M01 ----------
UTRZKY=[
 ("Odvézt všechny obyvatele do bezpečí před dopadem komety.","původní zadání (archiv)"),
 ("Aby to bylo hezký.","Pan Změna"),
 ("Postavit největší Archu v kraji.","starosta"),
 ("Start nejpozději 30. den.","starosta"),
 ("Až to bude.","Předseda"),
 ("Co nejdřív, ideálně včera.","Ruda"),
 ("Archa unese 4 812 lidí a opravdu vzlétne.","Bára"),
 ("Všichni budou spokojení.","Pan Změna"),
 ("Prezentace se bude panu starostovi líbit.","starosta"),
 ("Bazén, vyhlídková terasa, fontána.","Bára"),
 ("Nic. Všechno je v rozsahu.","Ruda"),
 ("Rozhodneme za pochodu.","Ing. Framework"),
 ("Starosta Bohumil. Podepsal.","podpis sponzora"),
 ("Komise pro schvalování komisí, pokud schválí.","Předseda"),
 ("Ten, kdo bude zrovna na poradě.","Pan Změna"),
 ("…a následné fáze.","Předseda"),
]
PORADI_U=list(range(len(UTRZKY))); random.Random(11).shuffle(PORADI_U)
U={orig: f"U{pos+1}" for pos,orig in enumerate(PORADI_U)}
KOLONKY=["Co chceme dokázat","Do kdy","Poznáme, že se to povedlo, když…","Co dělat nebudeme","Kdo to podepisuje a rozhoduje"]
# ---------- M02 ----------
POSTAVY=[
 ("Starosta Bohumil","Podepisuje všechno, co se dá vyfotit pro noviny."),
 ("Předseda Věčný","Bez jeho razítka se ve městě nehne ani papír."),
 ("Paní z chaloupky pod rampou","Peče buchty a zalévá rajčata. Nikdo si jí nevšímá."),
 ("Pan Změna","Mluví do všeho. Každý den chce něco jiného."),
 ("Bára","Ví o Arše nejvíc. Nikdo se jí neptá."),
 ("Vrátný","Archa ho má odvézt. Ví, kdo kde sedí."),
 ("Archivář Lumír","Archa ho má odvézt. Katalogizuje zkrachovalé projekty."),
 ("Ing. Framework","Prodává krabice s metodikami. Zítra bude prodávat jinde."),
]
STOPY=[
 ("Katastrální mapa: pozemek pod rampou patří paní Pozemkové.","archiv"),
 ("Kocour z chaloupky se tváří, jako by mu patřila půlka města.","rozhovor s kocourem"),
 ("Bára: „Když mě necháš domluvit: bez kajut pro všechny to nemá smysl.“","jen když ji Ruda nechal domluvit"),
 ("Vrátný: „Starosta podepíše cokoli, co bude v novinách.“","rozhovor s vrátným"),
]

def m03_deska():
    return """<div class='strana'><h1>M03 Souboj argumenty se starostou</h1>
<p><b>Hrají:</b> starosta (vede test) a Ruda (testér). Starosta má balíček námitek, Ruda drží repliky v ruce.</p>
<h3>Příprava</h3><ul>
<li>Námitky (N1–N6) zamíchat a položit lícem dolů.</li>
<li><b>Varianta A (hráč, který dával pozor):</b> Ruda dostane všech 15 replik (K1–K15).</li>
<li><b>Varianta B (hráč, který spěchal):</b> Ruda dostane všechny repliky kromě """+", ".join(K[i] for i in (1,2,4,5))+""" (dobré repliky z archivu, od Báry a od vrátného).</li></ul>
<h3>Kolo</h3><ul>
<li>Starosta otočí námitku a přečte ji s patřičným patosem.</li>
<li>Ruda zahraje jednu repliku. Každou repliku lze použít jen jednou.</li>
<li><b>Dobrá replika, která na námitku sedí</b> (podle klíče níže): bod pro Rudu.</li>
<li><b>Rychlá replika, která na námitku sedí:</b> bod pro Rudu, ale k tomu žeton <b>Slib</b>.</li>
<li><b>Cokoli jiného:</b> bod pro starostu. Starosta to okomentuje („To jste řekl hezky. A co tím myslíte?“).</li>
<li>Kdo má první <b>3 body</b>, vyhrál.</li></ul>
<h3>Konec</h3><ul>
<li>Ruda vyhrál a má <b>3 žetony Slib</b>: přečti „Slíbil jste všechno“ (níže).</li>
<li>Ruda prohrál: může se vrátit s lepšími replikami (ve variantě B mu přidej repliky, které neměl) a hrát znovu.</li></ul>
<p><b>Slíbil jste všechno:</b> <i>„Výborně! Tak největší Archa na světě, do pátku, skoro zadarmo, a za všechno ručíte vy. Podepíšu to dvakrát!“</i> (Ve hře se to vrátí ve 4. kapitole.)</p>
<h3>Žetony Slib (vystřihnout)</h3>
<div>"""+"".join("<span class='zeton'>Slib</span>" for _ in range(6))+"""</div>
<h3>Klíč pro starostu (repliky, které sedí)</h3>
<table><tr><th>Námitka</th><th>Dobrá</th><th>Rychlá (+ Slib)</th></tr>"""+"".join(f"<tr><td>N{i+1} {E(n[0])}</td><td>{K[i]}</td><td>{K[6+i]}</td></tr>" for i,n in enumerate(NAMITKY))+"""</table>
<p class='mala'>Fráze """+", ".join(K[12+i] for i in range(3))+""" nesedí nikdy. Sleduj, jestli je testér zkouší (jsou vtipné, ale prohrávají).</p></div>"""

def m01_deska():
    return f"""<div class='strana'><h1>M01 Charter z trosek</h1>
<p><b>Příběh:</b> původní listina Archy se rozpadla na útržky a každý do ní podstrčil něco svého. Ruda ji
musí slepit tak, aby ji Komise orazítkovala a aby z ní bylo jasné, co se staví.</p>
<h3>Pravidla</h3><ul>
<li>Testér dostane všech 16 útržků (U1–U16) zamíchaných.</li>
<li>Do každé kolonky listiny dá <b>nejvýš jeden</b> útržek. Kolonku může nechat prázdnou.</li>
<li>Útržky, které nepoužije, odloží. Útržek „…a následné fáze“ lze přilepit kamkoli navíc.</li>
<li>Žádný časový limit; testér má přemýšlet nahlas.</li></ul>
<h3>Vyhodnocení (vede test)</h3>
<table><tr><th>Kolonka</th><th>Správně</th><th>Body</th></tr>
<tr><td>{KOLONKY[0]}</td><td>{U[0]}</td><td>1</td></tr>
<tr><td>{KOLONKY[1]}</td><td>{U[3]}</td><td>1</td></tr>
<tr><td>{KOLONKY[2]}</td><td>{U[6]}</td><td>1</td></tr>
<tr><td>{KOLONKY[3]}</td><td>{U[9]}</td><td>bez bodu, jen zaznamenat</td></tr>
<tr><td>{KOLONKY[4]}</td><td>{U[12]}</td><td>bez bodu, jen zaznamenat</td></tr>
<tr><td>navíc</td><td>{U[15]} nepoužít</td><td>použitý {U[15]} = Ruda přijal „následné fáze“ (R1.4)</td></tr></table>
<p>Kvalita charteru = 0–3 body. Ve hře podle ní Komise reaguje a ve 4. kapitole se z ní berou argumenty.</p></div>
<div class='strana'><h1>Listina Archy</h1><p class='mala'>Herní deska pro M01: útržky se pokládají do kolonek.</p>
<table class='deska'>"""+"".join(f"<tr><th style='width:55mm'>{E(k)}</th><td></td></tr>" for k in KOLONKY)+"""<tr><th>Navíc</th><td style='height:25mm'></td></tr></table></div>"""

def m02_deska():
    return """<div class='strana'><h1>M02 Kdo tu vlastně velí</h1>
<p><b>Příběh:</b> před Komisí si Ruda (na Pembokovu radu) nakreslí, kdo o Arše rozhoduje a koho to zajímá.</p>
<h3>Pravidla</h3><ul>
<li>Testér dostane karty postav (P1–P8) a <b>stopy</b>, které ve hře „posbíral“.</li>
<li><b>Varianta A:</b> všechny stopy (S1–S4). <b>Varianta B:</b> jen S4 (spěchal a babičku přehlédl).</li>
<li>Postavy rozmístí do čtyř polí mapy. Může přemýšlet nahlas a měnit názor.</li></ul>
<h3>Vyhodnocení (vede test)</h3>
<table><tr><th>Postava</th><th>Pole</th></tr>
<tr><td>Starosta</td><td>Hodně může / zajímá ho to středně: <b>udržet spokojeného</b> (nebo získat)</td></tr>
<tr><td>Předseda</td><td><b>Získat na svou stranu</b></td></tr>
<tr><td>Paní z chaloupky (babička Pozemková)</td><td><b>Udržet spokojeného</b>: jen se stopou S1 nebo S2 to lze poznat</td></tr>
<tr><td>Pan Změna</td><td><b>Pravidelně informovat</b></td></tr>
<tr><td>Bára</td><td><b>Pravidelně informovat</b> (zatím; ve hře její vliv poroste)</td></tr>
<tr><td>Vrátný, archivář</td><td><b>Pravidelně informovat</b></td></tr>
<tr><td>Ing. Framework</td><td><b>Nezapomenout</b> (málo může, Archa ho nezajímá)</td></tr></table>
<p>Hlavně sleduj: <b>umístil babičku vysoko, aniž by měl stopu?</b> (Pak hádá podle „herní logiky“, ne podle hry.)
<b>Umístil ji nízko i se stopou?</b> (Pak stopa není dost jasná.)</p></div>
<div class='strana'><div class='mrizka'>
<div class='osa svisla'>Kolik toho může zařídit nebo zatrhnout ↑</div>
<div class='pole'>Udržet spokojeného</div><div class='pole'>Získat na svou stranu</div>
<div class='osa svisla'></div>
<div class='pole'>Nezapomenout</div><div class='pole'>Pravidelně informovat</div>
<div></div><div class='osa' style='grid-column:2/4'>Jak moc ho Archa zajímá →</div>
</div></div>"""

def pruvodce():
    return """<div class='strana'><h1>Papírové zkoušky miniher, kapitola 1</h1>
<p>Tři minihry z kapitoly 1 na papíře, než se naprogramují (F1 v plánu kapitoly 1).
Cíl: ověřit, že pravidla jdou pochopit bez vysvětlování, že hra baví i lidi, kteří o řízení projektů
nic neví, a že „správná“ řešení jdou odvodit z příběhu, ne z učebnice.</p>
<h2>Jak test vést</h2><ul>
<li><b>3–5 testerů</b>, aspoň 2 bez zkušenosti s projekty. Každý hraje sám, 20–30 minut na všechny tři hry.</li>
<li>Pořadí jako ve hře: <b>M03</b> (starosta), <b>M02</b> (mapa), <b>M01</b> (listina).</li>
<li>Před hrou přečti testérovi jen příběhový úvod (rámeček u každé hry). Pravidla <b>nevysvětluj</b>,
  dej mu je přečíst. Když se zasekne, napiš si kde a pak pomoz.</li>
<li>Testér <b>přemýšlí nahlas</b>. Ty mlčíš a píšeš si, co říká, čemu se smál a kde váhal.</li>
<li>Každou hru zkus s polovinou testerů ve variantě A, s polovinou ve variantě B.</li></ul>
<h2>Co sledovat</h2><ul>
<li>Pochopil pravidla z textu? Kde se ptal?</li>
<li>Smál se? Které karty zabraly, které ne?</li>
<li>U M03: zkoušel rychlé repliky? Uvědomil si, že něco slibuje?</li>
<li>U M02: odvodil babičku ze stop, nebo hádal?</li>
<li>U M01: chápe kolonky bez odborných slov? Lákal ho útržek „…a následné fáze“?</li>
<li>Jak dlouho hra trvala (cíl: 5–10 minut)?</li></ul>
<h2>Otázky po hře</h2><ol>
<li>Co jsi v té hře vlastně dělal? (Vlastními slovy.)</li>
<li>Co bylo nejvtipnější? Co bylo nudné?</li>
<li>Bylo něco nespravedlivé nebo nejasné?</li>
<li>Hrál bys to ve hře, nebo bys to přeskočil?</li>
<li>(Jen M01, M02) Myslíš, že by ti to k něčemu bylo v práci nebo ve škole?</li></ol>
<h2>Záznam</h2>
<table><tr><th>Testér</th><th>Zkušenost s projekty</th><th>Hra / varianta</th><th>Čas</th><th>Výsledek</th><th>Poznámky</th></tr>"""+"".join("<tr><td style='height:12mm'></td><td></td><td></td><td></td><td></td><td></td></tr>" for _ in range(6))+"""</table>
<p class='mala'>Karty jsou česky; anglická verze se otestuje až ve hře. Vytiskni jednostranně, karty rozstříhej podle čárkovaných čar.</p></div>"""

body=pruvodce()+m03_deska()
def karty2(seznam, trida, druh, pismeno):
    out=[]
    for i,(text,zdroj) in enumerate(seznam):
        out.append(f"<div class='karta {trida}'><div class='druh'>{E(druh)}</div><div class='text'>{E(text)}</div>"+(f"<div class='zdroj'>{E(zdroj)}</div>" if zdroj else "")+f"<div class='cislo'>{pismeno}{i+1}</div></div>")
    return out
def stranky(karty_):
    while len(karty_)%9: karty_.append("<div class='karta' style='border-color:transparent'></div>")
    return "".join(f"<div class='strana karty'>{''.join(karty_[i:i+9])}</div>" for i in range(0,len(karty_),9))
body+=stranky(karty2([(n[0],"") for n in NAMITKY],"namitka","Námitka starosty","N")+karty2([(REPLIKY[i][0],"") for i in PORADI_K],"replika","Rudova replika","K"))
body+=m02_deska()+stranky(karty2(POSTAVY,"postava","Postava","P")+karty2(STOPY,"stopa","Stopa","S"))
body+=m01_deska()+stranky(karty2([UTRZKY[i] for i in PORADI_U],"utrzek","Útržek listiny","U"))
open(os.path.join(os.path.dirname(os.path.abspath(__file__)),"kapitola-1.html"),"w").write(f"<!doctype html><html lang='cs'><head><meta charset='utf-8'><title>Papírové zkoušky miniher, kapitola 1</title><style>{CSS}</style></head><body>{body}</body></html>")
print("ok")
