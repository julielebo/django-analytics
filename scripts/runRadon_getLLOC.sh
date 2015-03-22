#!/bin/bash

DJANGO=$1

echo "Running on DJANGO: $DJANGO"

DJBASE=$(basename $DJANGO)
mkdir -p ../data/$DJBASE
cd ../data/$DJBASE
echo "DJANGO release: $DJBASE"

echo "Output will go in dir: " `pwd`

radon \
    raw \
    --summary \
    $DJANGO/django \
    > djangosrc_raw_summary.out

echo "" >> djangosrc_raw_summary.out
echo "DJANGO = " $DJANGO >> djangosrc_raw_summary.out

radon \
    raw \
    --summary \
    $DJANGO/tests \
    > djangotest_raw_summary.out

echo "" >> djangotests_raw_summary.out
echo "DJANGO = " $DJANGO >> djangotests_raw_summary.out

cd -


##last 7 lines of each outfile shows *Total* data which is what we want here
