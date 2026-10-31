#!/bin/sh
# Rozřeže a zarovná všechny animace postavy z listů v docs/styl/vzorky/ (podle docs/styl/animace-postav.md).
# Spuštění z kořene repozitáře:  sh hra/nastroje/zpracuj_animace.sh ruda
# Z každého listu se vezme nejnovější verze (<postava>-<animace>_vNN.png).
set -e
POSTAVA=${1:?Zadej postavu, např. ruda}
KOREN=$(git rev-parse --show-toplevel)
VZORKY="$KOREN/docs/styl/vzorky"
CIL="$KOREN/hra/grafika/postavy"
DOC=$(mktemp -d)
trap 'rm -rf "$DOC"' EXIT

posledni() { ls "$VZORKY/$POSTAVA-$1"_v*.png 2>/dev/null | sort | tail -1; }

# list  od  do  sada  (fáze od–do po řádcích zleva doprava)
zpracuj() {
	LIST=$(posledni "$1")
	[ -n "$LIST" ] || { echo "Chybí list $POSTAVA-$1, přeskakuji"; return; }
	if [ ! -d "$DOC/$1" ]; then
		godot --headless --path "$KOREN/hra" --script res://nastroje/rozdel_casti.gd -- "$LIST" "$DOC/$1" faze > "$DOC/$1.log" 2>&1
		echo "$(basename "$LIST"): $(grep -c '^faze_' "$DOC/$1.log") fází"
	fi
	mkdir -p "$DOC/sada_$4"
	i=$2
	while [ "$i" -le "$3" ]; do
		cp "$DOC/$1/faze_$(printf %02d "$i").png" "$DOC/sada_$4/"
		i=$((i + 1))
	done
	# Smazat jen obrázky a popis fází; soubory .import zůstanou, aby se neměnila UID v Godotu
	rm -f "$CIL/${POSTAVA}_$4"/faze_*.png "$CIL/${POSTAVA}_$4"/faze.json
	godot --headless --path "$KOREN/hra" --script res://nastroje/sestav_faze.gd -- "$DOC/sada_$4" "$CIL/${POSTAVA}_$4" 2>&1 | grep "^Fází" | sed "s/^/  $4: /"
}

zpracuj model 1 3 model
zpracuj chuze-bok 1 12 chuze_bok
# Chůze bokem v03 má vzdálenou nohavici tmavší (podle zadání), ve hře to ruší
godot --headless --path "$KOREN/hra" --script res://nastroje/zesvetli_nohavice.gd -- "$CIL/${POSTAVA}_chuze_bok" > /dev/null 2>&1
zpracuj chuze-predu 1 8 chuze_predu
zpracuj chuze-zezadu 1 8 chuze_zezadu
zpracuj stani 1 4 stani_bok
zpracuj stani 5 8 stani_predu
zpracuj mluveni 1 6 mluveni_bok
zpracuj mluveni 7 12 mluveni_predu
zpracuj akce 1 6 zvednuti
zpracuj akce 7 12 pouziti
