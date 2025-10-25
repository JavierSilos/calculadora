#!/bin/bash

HISTORICO="historico.txt"
USUARIO=$(whoami)

while true; do
    clear
    echo "=== MENÚ DE CALCULADORA ==="
    echo "1. Suma de dos números"
    echo "2. Resta de dos números"
    echo "3. Multiplicación de dos números"
    echo "4. División de dos números"
    echo "5. Potencia (base^exponente)"
    echo "6. Mostrar histórico de operaciones"
    echo "7. Borrar histórico de operaciones"
    echo "8. Exportar histórico a archivo"
    echo "9. Salir"
    read -p "Seleccione una opción: " OPCION

    case $OPCION in
        1)
            read -p "Ingrese el primer número: " A
            read -p "Ingrese el segundo número: " B
            RES=$(echo "$A + $B" | bc)
            echo "Resultado: $RES"
            echo "$(date '+%d/%m/%Y %H:%M') $USUARIO $A+$B $RES" >> $HISTORICO
            read -p "Enter para continuar..."
            ;;
        2)
            read -p "Ingrese el primer número: " A
            read -p "Ingrese el segundo número: " B
            RES=$(echo "$A - $B" | bc)
            echo "Resultado: $RES"
            echo "$(date '+%d/%m/%Y %H:%M') $USUARIO $A-$B $RES" >> $HISTORICO
            read -p "Enter para continuar..."
            ;;
        3)
            read -p "Ingrese el primer número: " A
            read -p "Ingrese el segundo número: " B
            RES=$(echo "$A * $B" | bc)
            echo "Resultado: $RES"
            echo "$(date '+%d/%m/%Y %H:%M') $USUARIO $A*$B $RES" >> $HISTORICO
            read -p "Enter para continuar..."
            ;;
        4)
            read -p "Ingrese el primer número: " A
            read -p "Ingrese el segundo número: " B
            if [ "$B" == "0" ]; then
                echo "Error: División entre cero"
            else
                RES=$(echo "scale=2; $A / $B" | bc)
                echo "Resultado: $RES"
                echo "$(date '+%d/%m/%Y %H:%M') $USUARIO $A/$B $RES" >> $HISTORICO
            fi
            read -p "Enter para continuar..."
            ;;
        5)
            read -p "Ingrese la base: " A
            read -p "Ingrese el exponente: " B
            RES=$(echo "$A ^ $B" | bc)
            echo "Resultado: $RES"
            echo "$(date '+%d/%m/%Y %H:%M') $USUARIO $A^$B $RES" >> $HISTORICO
            read -p "Enter para continuar..."
            ;;
        6)
            if [ -f $HISTORICO ]; then
                cat $HISTORICO
            else
                echo "No hay historial"
            fi
            read -p "Enter para continuar..."
            ;;
        7)
            > $HISTORICO
            echo "Histórico borrado"
            read -p "Enter para continuar..."
            ;;
        8)
            read -p "Ingrese el nombre del archivo a exportar: " ARCHIVO
            if [ -f $HISTORICO ]; then
                cp $HISTORICO $ARCHIVO
                echo "Histórico exportado a $ARCHIVO"
            else
                echo "No hay historial para exportar"
            fi
            read -p "Enter para continuar..."
            ;;
        9)
            echo "Saliendo..."
            exit 0
            ;;
        *)
            echo "Opción no válida"
            read -p "Enter para continuar..."
            ;;
    esac
done
