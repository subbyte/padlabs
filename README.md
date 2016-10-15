# Program Anomaly Detection Labs

### Lab Demo

Part of this lab is used in the 2016 ACM Conference on Computer and Communications Security (CCS) Tutorial:

* [Program Anomaly Detection: Methodology and Practices](https://www.sigsac.org/ccs/CCS2016/tutorials/#anomaly)
 * 10:00 AM - 11:30 AM
 * Oct 25, 2016
 * Hofburg Palace, Vienna, Austria
 * [Lab tasks in the tutorial](https://github.com/subbyte/padlabs/blob/master/src/ccs2016.tut01.md)

### Included Scripts

* n-gram/shingle model: the script will generate n-grams to construct the model
* deterministic finite automaton (DFA) model: the script will generate DFA vertices/edges for Neo4J visualization

### Example: Data-Driven Program Anomaly Detection Workflow (n-gram Model)

1. Generate training traces
 ```bash
 strace -o ls.trace ls .
 ```

2. Extract pure syscalls
 ```bash
 tr '[:upper:]' '[:lower:]' < ls.trace | sed '/^[^a-z_]/d' | sed 's/(.*//' > sys.list
 ```

3. Build the profile using scripts in `src`
 ```bash
 ./shingling.sh sys.list 4
 ```

4. Merge multiple training profiles to construct the normal behaivor model
 ```bash
 cat profiles | sort -u > modelfile
 ```
 
5. Generate testing traces and detect anomalies
 ```bash
 comm -13 training testing
 ```
