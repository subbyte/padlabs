# padlabs: Program Anomaly Detection Labs

Part of this lab is used in the 2016 ACM Conference on Computer and Communications Security (CCS) Tutorial:

* [Program Anomaly Detection: Methodology and Practices](https://www.sigsac.org/ccs/CCS2016/tutorials/#anomaly)
 * 10:00 AM - 11:30 AM
 * Oct 25, 2016
 * Hofburg Palace, Vienna, Austria

An example of data-driven program anomaly detection workflow:

1. Generate training traces, e.g., `strace -o ls.trace ls .`
2. Extract pure syscalls, e.g., `tr '[:upper:]' '[:lower:]' < ls.trace | sed '/^[^a-z_]/d' | sed 's/(.*//' > sys.list`
3. Build the profile using scripts in `src`, e.g., `./shingling.sh sys.list 4`
4. Merge multiple training profiles to construct the normal behaivor model, e.g., `cat profiles | sort -u > modelfile`
5. Generate testing traces and detect anomalies, e.g., `comm -13 training testing`
