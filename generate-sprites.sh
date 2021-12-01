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

# Get sprites from 'logos' folder
rm resources/sprites/logos/*.png 
for file in resources/sprites/original/logos/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --sheet ${f}.png
    echo ${f}.png
done
mv resources/sprites/original/logos/*.png resources/sprites/logos/

# Get sprites from 'player' folder
rm resources/sprites/player/*.png 
for file in resources/sprites/original/player/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --sheet ${f}.png
    echo ${f}.png
done
mv resources/sprites/original/player/*.png resources/sprites/player/

# Get sprites from 'inventory' folder
rm resources/sprites/inventory/*.png 
for file in resources/sprites/original/inventory/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --sheet ${f}.png
    echo ${f}.png
done
mv resources/sprites/original/inventory/*.png resources/sprites/inventory/

# Get sprites from 'maps' folder
rm resources/sprites/maps/*.png 
for file in resources/sprites/original/maps/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --sheet ${f}.png
    echo ${f}.png
done
mv resources/sprites/original/maps/*.png resources/sprites/maps/

# Get sprites from 'cutscenes/intro' folder
rm resources/sprites/cutscenes/intro/*.png 
for file in resources/sprites/original/cutscenes/intro/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --sheet ${f}.png
    echo ${f}.png
done
mv resources/sprites/original/cutscenes/intro/*.png resources/sprites/cutscenes/intro/

# Get sprites from 'cutscenes/start' folder
rm resources/sprites/cutscenes/start/*.png 
for file in resources/sprites/original/cutscenes/start/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --sheet ${f}.png
    echo ${f}.png
done
mv resources/sprites/original/cutscenes/start/*.png resources/sprites/cutscenes/start/

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
