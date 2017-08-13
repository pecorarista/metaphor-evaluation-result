#!/bin/bash

filename="result.csv"
dbname="metaphor"
tablename="results"

cat $filename \
    | psql -U $USER -d $dbname -c "copy $tablename from stdin csv header delimiter ',';"
