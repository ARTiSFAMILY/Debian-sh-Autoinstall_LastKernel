#!/bin/bash
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
    exit 1
fi
 
mkdir tmp && cd tmp
url="http://kernel.ubuntu.com/~kernel-ppa/mainline/daily/current"
files="$(wget -c "$url" -q -O - | grep $1.deb | grep -v 'i386' | sed -e 's,.*<a href="\(.*\.deb\)">.*,\1,')"
for f in $files ; do
     wget -c "$url/$f"
done
files="$(wget -c "$url" -q -O - | grep all.deb | sed -e 's,.*<a href="\(.*\.deb\)">.*,\1,')"
for f in $files ; do
     wget -c "$url/$f"
done
  
dpkg -i *.deb
cd .. && rm -rf tmp
echo "Done ..."
