#!/bin/bash

if [ $# -lt 1 ]; then
    echo -e "\e[31mERROR: No file name argument passed. \e[39m "
    exit 1
fi

echo -e "\e[94m[1 of 9] Downloading and unzipping database from FAA website... \e[39m "
wget -q http://registry.faa.gov/database/ReleasableAircraft.zip 
unzip -q ReleasableAircraft.zip

rm $1
touch $1

echo -e "\e[34m[2 of 9] Inserting table 'AircraftReference'... \e[39m "
sqlite3 -csv $1 ".import ACFTREF.txt AircraftReference"
echo -e "\e[34m[3 of 9] Inserting table 'DealerApplicant'... \e[39m "
sqlite3 -csv $1 ".import DEALER.txt DealerApplicant"
echo -e "\e[34m[4 of 9] Inserting table 'Deregistered'... \e[39m "
sqlite3 -csv $1 ".import DEREG.txt Deregistered"
echo -e "\e[34m[5 of 9] Inserting table 'DocumentIndex'... \e[39m "
sqlite3 -csv $1 ".import DOCINDEX.txt DocumentIndex"
echo -e "\e[34m[6 of 9] Inserting table 'EngineReference'... \e[39m "
sqlite3 -csv $1 ".import ENGINE.txt EngineReference"
echo -e "\e[34m[7 of 9] Inserting table 'Registrations'... \e[39m "
sqlite3 -csv $1 ".import MASTER.txt Registrations"
echo -e "\e[34m[8 of 9] Inserting table 'ReservedNumbers'... \e[39m "
sqlite3 -csv $1 ".import RESERVED.txt ReservedNumbers"

echo -e "\e[94m[9 of 9] Cleaning up...\e[39m "
rm ardata.pdf
rm *.txt
rm *.zip

echo -e "\n\e[94mComplete.\e[39m "