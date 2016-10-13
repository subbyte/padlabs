# Firefox Sample Traces

Each trace contains all system calls captured from an entire Firefox execution. The user click "exit" to close Firefox at the end. All child processes are included.

Execution Environment
* OS image: linuxmint-13-cinnamon-dvd-32bit.iso
* kernel: Linux mint 3.2.0-23-generic
* Firefox: Mozilla Firefox 12.0

Exploit Information
* Exploit: CVE-2014-8636
* metasploit exploit: exploit/multi/browser/firefox_proxy_prototype
* metasploit payload: firefox/shell_reverse_tcp
* activities after exploit: only `uname -a`

Benign/normal traces:
* ff.benign.[01-05]

Exploit trace:
* ff.exploited.cve-2014-8636
