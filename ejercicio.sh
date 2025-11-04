#!/bin/bash


crear_archivos() {
    local dir=$1
    local cantidad=$2

    if [ $cantidad -gt 0 ]; then
        for ((i=1; i<=cantidad; i++)); do
            touch "$dir/F$i.txt"
            ((archivos_txt++))
        done
    else
        touch "$dir/vacio.cf"
        ((archivos_cf++))
    fi
}


if [ $# -eq 0 ]; then
    echo "Error :: Proporcione un archivo para procesar"
    exit 1
fi

archivo=$1

if [ ! -f "$archivo" ]; then
    echo "Error :: El archivo $archivo no existe"
    exit 1
fi


directorios_creados=0
archivos_txt=0
archivos_cf=0


while read -r directorio; do
    # Evita procesar líneas vacías
    [ -z "$directorio" ] && continue

    mkdir -p "$directorio"
    ((directorios_creados++))

    echo "¿Cuántos archivos desea crear en el directorio '$directorio'?"
    read cantidad

    # Validar que la entrada sea un número
    while ! [[ $cantidad =~ ^[0-9]+$ ]]; do
        echo "Error: Ingrese un número válido."
        read cantidad
    done

    crear_archivos "$directorio" "$cantidad"
done < "$archivo"


fecha=$(date +"%d/%m/%Y %H:%M")
usuario=$(whoami)

echo
echo "Fecha: $fecha"
echo "Usuario: $usuario"
echo "Cantidad de directorios generados: $directorios_creados"
echo "Archivos txt creados: $archivos_txt"
echo "Archivos cf creados: $archivos_cf"
