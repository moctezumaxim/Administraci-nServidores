#!/usr/bin/env bash

PAPELERA="$HOME/.papelera"

ayuda() {
    echo "Uso: $0 <archivo_a_borrar>"
    echo "Mueve el archivo a $PAPELERA para poder recuperarlo después."
}

if [ ! -d "$PAPELERA" ]; then
    mkdir -p "$PAPELERA"
fi

if [ "$#" -ne 1 ]; then
    ayuda
    exit 1
fi

ARCHIVO="$1"

if [ ! -e "$ARCHIVO" ]; then
    echo "Error: El archivo '$ARCHIVO' no existe."
    exit 1
fi

NOMBRE=$(basename "$ARCHIVO")

mv "$ARCHIVO" "$PAPELERA/"
echo "El archivo '$NOMBRE' ha sido movido a la papelera."
