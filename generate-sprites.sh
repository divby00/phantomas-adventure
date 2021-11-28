#!/usr/bin/env bash

# Get sprites from 'root' folder
rm resources/sprites/*.png 
for file in resources/sprites/original/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --sheet ${f}.png
    echo ${f}.png
done
mv resources/sprites/original/*.png resources/sprites/

# Get sprites from 'dialogs' folder
rm resources/sprites/dialogs/*.png 
for file in resources/sprites/original/dialogs/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --sheet ${f}.png
    echo ${f}.png
done
mv resources/sprites/original/dialogs/*.png resources/sprites/dialogs/

# Get sprites from 'enemies' folder
rm resources/sprites/enemies/*.png 
for file in resources/sprites/original/enemies/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --sheet ${f}.png
    echo ${f}.png
done
mv resources/sprites/original/enemies/*.png resources/sprites/enemies/

# Get sprites from 'transitions' folder
rm resources/sprites/transitions/*.png 
for file in resources/sprites/original/transitions/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --sheet ${f}.png
    echo ${f}.png
done
mv resources/sprites/original/transitions/*.png resources/sprites/transitions/

# Get sprites from 'menu' folder
rm resources/sprites/menu/*.png 
for file in resources/sprites/original/menu/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --sheet ${f}.png
    echo ${f}.png
done
mv resources/sprites/original/menu/*.png resources/sprites/menu/

# Get sprites from 'ui' folder
rm resources/sprites/ui/*.png 
for file in resources/sprites/original/ui/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --sheet ${f}.png
    echo ${f}.png
done
mv resources/sprites/original/ui/*.png resources/sprites/ui/

# ------------------------------------------------
# Start with animated textures (one file per tile)
# ------------------------------------------------

# Get sprites from 'dialogs' folder
for file in resources/sprites/original/dialogs/separate/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --save-as ${f}.png
    echo ${f}.png
done
mv resources/sprites/original/dialogs/separate/*.png resources/sprites/dialogs/
echo Done!

# Get sprites from 'transitions' folder
for file in resources/sprites/original/transitions/separate/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --save-as ${f}.png
    echo ${f}.png
done
mv resources/sprites/original/transitions/separate/*.png resources/sprites/transitions/
echo Done!
