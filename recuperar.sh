#!/usr/bin/env bash

PAPELERA="$HOME/.papelera"

ayuda() {
    echo "Uso: $0 <nombre_del_archivo> <directorio_donde_restaurar>"
    echo "Ejemplo: $0 mi_archivo.txt ."
}

if [ "$#" -ne 2 ]; then
    ayuda
    exit 1
fi

ARCHIVO_NOMBRE="$1"
DESTINO="$2"

if [ ! -f "$PAPELERA/$ARCHIVO_NOMBRE" ]; then
    echo "Error: El archivo '$ARCHIVO_NOMBRE' no está en la papelera."
    exit 1
fi

if [ ! -d "$DESTINO" ]; then
    echo "Error: El directorio destino '$DESTINO' no existe."
    exit 1
fi

mv "$PAPELERA/$ARCHIVO_NOMBRE" "$DESTINO/"
echo "¡Éxito! '$ARCHIVO_NOMBRE' ha sido restaurado en '$DESTINO'."
