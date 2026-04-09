#!/bin/bash

LARGO_MINIMO=6
REQUIERE_NUMERO=1
REQUIERE_MAYUSCULA=1

read -p "Nombre de usuario: " username

if id "$username" &>/dev/null; then
    echo "El usuario ya existe"
    exit 1
fi

while true; do
    read -s -p "Contraseña: " pass
    echo
    read -s -p "Repetir contraseña: " pass2
    echo
    
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

read -p "¿Asignar cuota? (s/n): " cuota
if [[ "$cuota" == "s" ]]; then
    read -p "Soft MB: " soft
    read -p "Hard MB: " hard
    read -p "Gracia dias: " gracia
fi

read -p "¿Permitir sudo? (s/n): " sudo_perm
if [[ "$sudo_perm" == "s" ]]; then
    echo "1) Todos los comandos"
    echo "2) Comandos especificos"
    read -p "Opcion: " opt
    
    if [[ "$opt" == "2" ]]; then
        read -p "Comandos (separados por coma): " comandos
    else
        comandos="ALL"
    fi
fi

useradd -m "$username"
echo "$username:$pass" | chpasswd

if [[ "$cuota" == "s" ]]; then
    setquota -u "$username" $((soft*1024)) $((hard*1024)) 0 0 /
    setquota -t -u $gracia $gracia /
fi

if [[ "$sudo_perm" == "s" ]]; then
    echo "$username ALL=(ALL) $comandos" >> /etc/sudoers
fi

echo "Usuario $username creado"