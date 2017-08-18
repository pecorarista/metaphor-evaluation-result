#!/bin/bash

outdir="build"
scriptdir="$1"
sql=$(cat "$scriptdir/mean.sql")

psql -d metaphor -c "COPY ($sql) TO STDOUT DELIMITER ',' CSV HEADER;" > "${outdir}/mean-ja.csv"

for metric in "metaphoricity" "comprehensibility"
do
    for pos in "verb" "noun"
    do
        sql=$(cat "$scriptdir/sort-${pos}s-by-${metric}.sql")
        psql -d metaphor -c "COPY ($sql) TO STDOUT DELIMITER ',' CSV;" \
            > "${outdir}/${pos}s-sorted-by-${metric}-ja.csv"
    done
done
