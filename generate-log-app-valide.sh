year="2019-2019"
month="11-12"
day="1-31"
host="$((RANDOM%256)).$((RANDOM%256)).$((RANDOM%256)).$((RANDOM%256))"
other="-"
logname="-"
time1="$(printf "[")$(shuf -i$day -n1)/$(printf '%02d' $(shuf -i$month -n1))/$(printf '%02d' $(shuf -i$year -n1)):$(printf '%02d' $(shuf -i0-23 -n1)):$(printf '%02d' $(shuf -i0-59 -n1)):$(printf '%02d' $(shuf -i0-59 -n1)) $(printf +0100)$(printf "]")"
methodur1=$(printf '"GET / HTTP/1.0"')
code=$(printf '200')
bytesd=$(printf '907')
refererquot=$(printf '-')
uaquot=$(printf '"Mozilla/4.0 (compatible; MSIE 4.01; Windows NT)"')

echo "$host $other $logname $time1 $methodur1 $code $bytesd $refererquot $uaquot"
