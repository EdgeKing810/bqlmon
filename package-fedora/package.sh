#! /bin/bash

dnf install git make gcc ncurses ncurses-devel rpm-build rpm-devel rpmlint rpmdevtools coreutils -y

rpmdev-setuptree
cp bqlmon.spec ~/rpmbuild/SPECS/
rm -rf ~/rpmbuild/SOURCES/bqlmon*
rm -rf ~/rpmbuild/BUILD/bqlmon*

cd ~/
rm -rf bqlmon/
git clone https://github.com/ffainelli/bqlmon
cd bqlmon/

cat >> Makefile << 'EOF'

install:
        mkdir -p $(DESTDIR)/usr/bin
        install -m 0755 $(APP) $(DESTDIR)/usr/bin/$(APP)
EOF

rm -rf .git/
cd ../
mv bqlmon bqlmon-1.0
tar -cvzf bqlmon-1.0.tar.gz bqlmon-1.0/
cp bqlmon-1.0.tar.gz ~/rpmbuild/SOURCES/bqlmon

rpmbuild -bb ~/rpmbuild/SPECS/bqlmon.spec

bqlmon_rpm=$(find rpmbuild/ -type f -name "bqlmon*.rpm")
if [ "${#bqlmon_rpm[@]}" -gt 0 ]; then
  echo "Success! ${bqlmon_rpm[0]} can be distributed!"
fi
