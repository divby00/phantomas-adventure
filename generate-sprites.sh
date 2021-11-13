#!/usr/bin/env bash
rm resources/sprites/*.png 
for file in resources/sprites/original/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --sheet ${f}.png
    echo ${f}.png
done
mv resources/sprites/original/*.png resources/sprites/

# Start with animated textures (one file per tile)
for file in resources/sprites/original/separate/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --save-as ${f}.png
    echo ${f}.png
done
mv resources/sprites/original/separate/*.png resources/sprites/
echo Done!
