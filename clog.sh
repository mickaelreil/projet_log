#!/bin/bash
# Prétraitement des fichiers logs au format IDD_LOG_APP
#Déclarations des variables
input=${!#}
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
		regexps=$(cat $file | cut -d "=" -f 2)
		for val in $regexps
		do
	        	regexp=$regexp'('$val')[[:space:]]'
		done
		regexp=$(echo $regexp | sed "s/\[\[:space:\]\]$//g")
		format=$(./check_format.sh "$line" "$regexp" "$file")
		if [ ! -z "$format" ]
		then
			config=$file
			break 2
		fi
	done
done
if [ -z $config ]
then
	echo "error format"
	exit 1
fi
# Lecture/Vérification du fichier d'entrée
# 'uniq' supprime les doublons, voire plus
cat $input | uniq | while IFS= read -r line
do
	./check_format.sh "$line" "$regexp" "$config" 
done
