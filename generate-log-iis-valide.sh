year="2019-2019"
month="11-12"
day="1-31"
date="$(shuf -i$year -n1)-$(printf '%02d' $(shuf -i$month -n1))-$(printf '%02d' $(shuf -i$day -n1))"
time="$(printf '%02d' $(shuf -i0-23 -n1)):$(printf '%02d' $(shuf -i0-59 -n1)):$(printf '%02d' $(shuf -i0-59 -n1))"
c_ip="$((RANDOM%256)).$((RANDOM%256)).$((RANDOM%256)).$((RANDOM%256))"
cs_username="projetLog"
s_ip="89.251.63.195"
s_port="80"
cs_method="GET"
cs_uri_stem="/article-ecole.php3"
cs_uri_query="id_rubrique=5&id_ssrubrique=29&id_article=207"
sc_status="200"
cs="Mozilla/5.0+(Windows;+U;+Windows+NT+5.1;+fr;+rv:1.8.1.7)+Gecko/20070914+Firefox/2"

echo "$date $time $c_ip $cs_username $s_ip $s_port $cs_method $cs_uri_stem $cs_uri_query $sc_status $cs"

