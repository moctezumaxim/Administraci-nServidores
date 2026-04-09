#!/bin/bash

# REGLAS DE CONTRASEÑA
LARGO_MINIMO=6
REQUIERE_NUMERO=1
REQUIERE_MAYUSCULA=1

# Solicitar nombre de usuario
read -p "Nombre de usuario: " username

# Verificar si ya existe
if id "$username" &>/dev/null; then
    echo "El usuario ya existe"
    exit 1
fi

# Solicitar contraseña
while true; do
    read -s -p "Contraseña: " pass
    echo
    read -s -p "Repetir contraseña: " pass2
    echo
    
    # Validar
    if [[ "$pass" != "$pass2" ]]; then
        echo "ERROR: Las contraseñas no coinciden"
    elif [[ ${#pass} -lt $LARGO_MINIMO ]]; then
        echo "ERROR: La contraseña debe tener al menos $LARGO_MINIMO caracteres"
    elif [[ $REQUIERE_NUMERO -eq 1 && ! "$pass" =~ [0-9] ]]; then
        echo "ERROR: La contraseña debe tener al menos un numero"
    elif [[ $REQUIERE_MAYUSCULA -eq 1 && ! "$pass" =~ [A-Z] ]]; then
        echo "ERROR: La contraseña debe tener al menos una mayuscula"
    else
        break
    fi
done

# Crear usuario
useradd -m "$username"
echo "$username:$pass" | chpasswd

echo "Usuario $username creado exitosamente"