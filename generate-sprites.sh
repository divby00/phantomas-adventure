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
rm resources/sprites/transition*
for file in resources/sprites/original/transition*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --save-as ${f}.png
    echo ${f}.png
done
mv resources/sprites/original/*.png resources/sprites/
echo Done!
