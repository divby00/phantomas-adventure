#!/usr/bin/env bash

# Get sprites from 'title' folder
for file in resources/sprites/original/title/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --color-mode rgb --palette dawnbringer-32.pal --save-as ${f}.ase
done

# Get sprites from 'characters' folder
for file in resources/sprites/original/characters/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --color-mode rgb --palette dawnbringer-32.pal --save-as ${f}.ase
done

# Get sprites from 'dialogs' folder
for file in resources/sprites/original/dialogs/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --color-mode rgb --palette dawnbringer-32.pal --save-as ${f}.ase
done

# Get sprites from 'enemies' folder
for file in resources/sprites/original/enemies/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --color-mode rgb --palette dawnbringer-32.pal --save-as ${f}.ase
done

# Get sprites from 'menu' folder
for file in resources/sprites/original/menu/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --color-mode rgb --palette dawnbringer-32.pal --save-as ${f}.ase
done

# Get sprites from 'ui' folder
for file in resources/sprites/original/ui/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --color-mode rgb --palette dawnbringer-32.pal --save-as ${f}.ase
done

# Get sprites from 'logos' folder
for file in resources/sprites/original/logos/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --color-mode rgb --palette dawnbringer-32.pal --save-as ${f}.ase
done

# Get sprites from 'effects' folder
for file in resources/sprites/original/effects/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --color-mode rgb --palette dawnbringer-32.pal --save-as ${f}.ase
done

# Get sprites from 'player' folder
for file in resources/sprites/original/player/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --color-mode rgb --palette dawnbringer-32.pal --save-as ${f}.ase
done

# Get sprites from 'inventory' folder
for file in resources/sprites/original/inventory/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --color-mode rgb --palette dawnbringer-32.pal --save-as ${f}.ase
done

# Get sprites from 'maps' folder
for file in resources/sprites/original/maps/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --color-mode rgb --palette dawnbringer-32.pal --save-as ${f}.ase
done

# Get sprites from 'cutscenes/intro' folder
for file in resources/sprites/original/cutscenes/intro/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --color-mode rgb --palette dawnbringer-32.pal --save-as ${f}.ase
done

# Get sprites from 'cutscenes/start' folder
for file in resources/sprites/original/cutscenes/start/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --color-mode rgb --palette dawnbringer-32.pal --save-as ${f}.ase
done

# ------------------------------------------------
# Start with animated textures (one file per tile)
# ------------------------------------------------

# Get sprites from 'dialogs' folder
for file in resources/sprites/original/dialogs/separate/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --color-mode rgb --palette dawnbringer-32.pal --save-as ${f}.ase
done

# Get sprites from 'transitions' folder
for file in resources/sprites/original/transitions/separate/*.ase
do
    f=${file%%.*}
    ~/.steam/debian-installation/steamapps/common/Aseprite/aseprite -b ${f}.ase --color-mode rgb --palette dawnbringer-32.pal --save-as ${f}.ase
done

echo Done!
