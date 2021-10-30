#!/usr/bin/env bash
rm ./*.png
for file in original/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --sheet ${f}.png
    echo ${f}.png
done
mv ./original/*.png ./
echo Done!
