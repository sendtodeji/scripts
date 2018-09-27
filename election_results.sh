#!/bin/bash

echo -e "<html>\n" > ~/results/tally.html
echo -e "<head><title> Osun Election Results tally </title>\n<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n<meta http-equiv=\"refresh\" content=\"60\">\n</head>\n<body>\n" >> ~/results/tally.html
echo -e "<h3> Osun State Gubernatorial Election Results </h3>\n" >> ~/results/tally.html
curl -s https://www.channelstv.com/2018/09/23/live-updates-collation-of-osun-governorship-election-results/  | sed -s 's|>|>\n|g' > ~/page.html
egrep '[0-9]<br|[0-9]</p' ~/page.html | sed -e 's|<br\ />||g' -e 's|</p>||g' -e 's|,||g' -e 's|:| -|g' | sed -e 's| ||g' -e 's|–|,|g' -e 's|-|,|g' | awk -F',' '{a[$1]+=$2;} END { for (i in a) print i" | " a[i] "<br/>";}' | sort -t"|" -k2 -nr >> ~/results/tally.html

echo -n "<br/>Source: <a href=\"https://www.channelstv.com/2018/09/23/live-updates-collation-of-osun-governorship-election-results\" target=\"_blank\"> Channels TV </a>" >> ~/results/tally.html
echo -e "</body>\n</html>" >> ~/results/tally.html
