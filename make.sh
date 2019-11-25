#!/bin/bash

SRC="./src"
REL="./rel"

SCRIPT="text2binary.ts"
HTML="index.html"

if [ ! -d "$REL" ];
    then
        mkdir $REL;
    else
        rm $REL/*;
fi

echo "Compiling..." &&
tsc --module amd --target "ES2016" --outDir "$REL" --strict --sourceMap "$SRC/$SCRIPT" &&
echo "Copying html..." &&
cp "$SRC/$HTML" "$REL/$HTML" &&
echo "Success!"

