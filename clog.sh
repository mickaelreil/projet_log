#!/bin/bash
# Prétraitement des fichiers logs au format IDD_LOG_APP
#Déclarations des variables
input=$1
output=$2
month=$(ls -la --time-style=+%Y-%m-%d $1 | awk '{print $6}' | cut -d "-" -f 2)
year=$(ls -la --time-style=+%Y-%m-%d $1 | awk '{print $6}' | cut -d "-" -f 1)
dest="$output/$month-$year"
pwd=${0%/*}
if [ $pwd = $0 ]; then
	pwd="."
fi
if [ $1 = '' ] && [ $2 = '' ]; then
	echo "Entrez un fichier source et un répertoire de destination."
fi

if [ ! -d "$dest" ]; then
	mkdir -p "$dest"
fi

if [ ! -f "$input" ]; then
	echo "Le fichier n'existe pas."
	exit 1
fi


config=""
files=(
	".iisconfig"
	".appconfig"
)
lines=$(wc < $input | awk '{printf $1}')
regexp=""
#Déterminer le format
for n in $(seq $lines)
do
	line=$(head -n $n $input)
	for file in ${files[*]}
	do
		regexp=""
		regexps=$(cat "$pwd/$file" | cut -d "=" -f 2)
		for val in $regexps
		do
	        	regexp=$regexp'('$val')[[:space:]]'
		done
		regexp=$(echo $regexp | sed "s/\[\[:space:\]\]$//g")
		format=$(bash "$pwd/check_format.sh" "$line" "$regexp" "$file")
		if [ ! -z "$format" ]
		then
			config=$file
			break 2
		fi
	done
done
if [ -z $config ]
then
	echo "Erreur de format."
	exit 1
fi
# Lecture/Vérification du fichier d'entrée
# 'uniq' supprime les doublons, voire plus
cat $input | uniq | while IFS= read -r line
do

	bash "$pwd/check_format.sh" "$line" "$regexp" "$config"  >> "$dest/log-$(date +%m-%d-%y).txt"
done
