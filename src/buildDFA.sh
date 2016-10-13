#!/usr/bin/env bash

################################################################
#
#    Deterministic Finite Automaton (DFA) Builder
#    
#    Functionality: generate vertices/edges for a DFA given a
#        sequence of items, e.g., system call trace
#
#    Importing the output DFA to Neo4J for visualization:
#        $ bin/neo4j-import \
#          --into data/databases/graph.db \
#          --nodes:SYSCALL import/dfa.nodes \
#          --relationships:CALLS import/dfa.edges
#
#    Input example (lines in the input file):
#        sysa
#        sysb
#        sysc
#        sysd
#
#    Licence: GNU GPL v3.0
#
#    Author: Xiaokui Shu
#    Email: xiaokui.shu@ibm.com
#
################################################################

if [ "$#" -ne 2 ]; then
    echo "./buildDFAedge.sh syslist outputfile"
    echo "    will output outputfile.nodes outputfile.edges"
    exit 1
fi

# extract nodes
sort -u -o $2.nodes $1

# insert header for nodes file
sed -i '1 i SYSCALL:ID' $2.nodes

# extract edges
cp $1 $1.dfa.tmp.1
cp $1 $1.dfa.tmp.2
sed -i '$d' $1.dfa.tmp.1
sed -i '1d' $1.dfa.tmp.2
paste -d, $1.dfa.tmp.* > $1.dfa.tmp.dup
sort -u -o $2.edges $1.dfa.tmp.dup
rm $1.dfa.tmp.*

# insert header for edges file
sed -i '1 i CALLER:START_ID,CALLEE:END_ID' $2.edges
