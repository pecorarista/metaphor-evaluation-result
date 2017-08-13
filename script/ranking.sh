#!/bin/bash

dbname="metaphor"
tablename="results"

for metric in "comprehensibility" "metaphoricity" "novelty"
do
    sql=$(cat "script/ranking.sql" | sed -e "s/'metric'/'$metric'/")
    psql -U $USER -d $dbname -c "copy ($sql) to stdout csv header delimiter ','" > "${metric}-rank.csv"
done
