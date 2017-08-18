#!/bin/bash

dbname="metaphor"
tablename="results"
scriptdir="$1"

for metric in "comprehensibility" "metaphoricity" "novelty"
do
    sql=$(cat "$scriptdir/ranking.sql" | sed -e "s/'metric'/'$metric'/")
    psql -U $USER -d $dbname \
        -c "copy ($scriptdir/$sql) to stdout csv header delimiter ','" > "${metric}-rank.csv"
done
