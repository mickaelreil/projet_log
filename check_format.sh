#!/bin/bash
# Retourne une ligne, si le format correspond au fichier de configuration
enum_navigateur="Chrome|Firefox|MSIE"
enum_os="Macintosh|Windows"
case $3 in
".appconfig")
	if [[ $1 =~ $2 ]]
	then
		ip=${BASH_REMATCH[1]}
		day=${BASH_REMATCH[5]}
		month=${BASH_REMATCH[6]}
		year=${BASH_REMATCH[7]}
		hour=${BASH_REMATCH[8]}
		minute=${BASH_REMATCH[9]}
		second=${BASH_REMATCH[10]}
		url=${BASH_REMATCH[17]}
		code=${BASH_REMATCH[13]}
		uaquot=${BASH_REMATCH[18]}
		bytesd=${BASH_REMATCH[16]}
		navigateur=$(echo $(echo $uaquot|grep -o -E "$enum_navigateur"||echo "-") | awk '{print $1}')
		os=$(echo $(echo $uaquot|grep -o -E "$enum_os"||echo "-") | awk '{print $1}')
		echo "$ip;$year$month$day$hour$minute$second;$code;$url;$os;$navigateur;$bytesd"
	fi;;
".iisconfig")
	if [[ $1 =~ $2 ]]
	then
		ip=${BASH_REMATCH[9]}
		day=${BASH_REMATCH[4]}
                month=${BASH_REMATCH[3]}
                year=${BASH_REMATCH[2]}
                hour=${BASH_REMATCH[6]}
                minute=${BASH_REMATCH[7]}
                second=${BASH_REMATCH[8]}
	        url=${BASH_REMATCH[15]}
	        code=${BASH_REMATCH[17]}
		uaquot=${BASH_REMATCH[18]}
		bytesd="-"
		navigateur=$(echo $(echo -n $uaquot|grep -o -E "$enum_navigateur"||echo "-")| awk '{print $1}')
                os=$(echo $(echo -n $uaquot|grep -o -E "$enum_os"||echo "-")| awk '{print $1}')
		echo "$ip;$year$month$day$hour$minute$second;$code;$url;$os;$navigateur;$bytesd"
	fi;;
esac
