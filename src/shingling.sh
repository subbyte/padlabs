#!/usr/bin/env bash

################################################################
#
#    Shingling by Line
#    
#    Functionality: generate shingles (n-grams) from a sequence
#        of items, e.g., system call trace
#
#    Input example (lines in the input file):
#        sysa
#        sysb
#        sysc
#        sysd
#    Output example (lines in the output file):
#        sysa:sysb:sysc
#        sysb:sysc:sysd
#
#    Author: Xiaokui Shu
#    Email: xiaokui.shu@ibm.com
#
################################################################

if [ "$#" -ne 2 ]; then
    echo "./shingling.sh syslist n"
    echo "    syslist is a filename"
    echo "    n is an integer"
    echo "    will output syslist.n, syslist.n.freq"
    exit 1
fi

shingle_prev=$1
shingles_dup=$1.shingle.tmp.dup

# create shingle files
for i in `seq -w 1 $2`;
do
    shingle_curr=$1.shingle.tmp.$i
    cp $shingle_prev $shingle_curr
    if [ "$i" -ne "1" ]
    then
        sed -i '1d' $shingle_curr
    fi
    shingle_prev=$shingle_curr
done

# concatenate shingles
paste -d: $1.shingle.tmp.* > $shingles_dup

# clean short tails
sed -i '/:$/d' $shingles_dup

# output syslist.n
sort -u -o $1.$2 $shingles_dup

# output syslist.n.freq
sort $shingles_dup | uniq -c > $1.$2.freq

# clean temp files
rm $1.shingle.tmp.*
