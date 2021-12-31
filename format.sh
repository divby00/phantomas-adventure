#!/usr/bin/env bash
if ! [ -x "$(command -v gdformat)" ]; then
    echo 'Error: gdtoolkit is not installed.' >&2
    exit 1
else
    gdformat $(find . -name '*.gd') --line-length=120
fi
