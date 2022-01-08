#!/usr/bin/env bash
for file in docs/*.md
do
    f=${file%%.*}
    echo ${f}
    pandoc --self-contained -f markdown+implicit_figures -s -o ${f}.pdf ${f}.md
done

