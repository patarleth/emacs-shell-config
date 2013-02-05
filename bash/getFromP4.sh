P4URL='http://perforce.corp.espn3.com/@md=d&cd=//vss_espneng/Projects/Espn/espn-sports/E2/Envoy/&pat=*&is=y&c=2Co@//vss_espneng/Projects/Espn/espn-sports/E2/Envoy/?ac=30'

if [ $# -eq 1 ]
then
  P4URL=$1
fi

curl $P4URL | egrep -o 'showMenu\(\\"[^"]+"' | egrep -o '"[^\\].*"' | egrep -v '/\\"' | sed 's:%2F:/:g' | sed 's/"\(.*\)\\"/\1/g' > p4Urls.txt