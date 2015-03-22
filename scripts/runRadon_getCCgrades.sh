#!/bin/bash

DJANGO=$1

STARTDIR=`pwd`

echo "Running on DJANGO: $DJANGO"

DJBASE=$(basename $DJANGO)
mkdir -p ../data/$DJBASE
cd ../data/$DJBASE
echo "DJANGO release: $DJBASE"

OUTDIR=`pwd`
echo "Output will go in dir: " $OUTDIR

cd $DJANGO

outfile=$OUTDIR/djangosrc_cc_summary.out
radon \
    cc \
    --total-average \
    --show-complexity \
    ./django \
    > $outfile
 ##TODO! change to all src

 #last line of radon output has the average complexity
grep "Average complexity" $outfile > ${outfile}_avg_cc

echo "" >> $outfile
echo "DJANGO = " $DJANGO >> $outfile

outfile=$OUTDIR/djangosrc_cc_json.out
radon \
    cc \
    --total-average \
    --show-complexity \
    --json \
    ./django \
    > $outfile
 ##TODO! change to all src


perl $STARTDIR/parseCcJson.pl $outfile ${outfile}_grades ${outfile}_cc_filerank


cd -


