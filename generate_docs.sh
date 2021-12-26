#!/usr/bin/env bash
for file in docs/*.md
do
    f=${file%%.*}
    echo ${f}
    pandoc -s -o ${f}.pdf ${f}.md
done

