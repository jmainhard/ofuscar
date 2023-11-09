#!/bin/bash

alphanumeric='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
scrambled='9B8Z7Y6X5W4V3U2T1S0RQPOrNMLKJIHGFEDCBAzyxwvutsrqponmlkjihgfedcba'

# substitute -> transpose -> reverse funciona correctamente
# FIXME: vicersa no recupera el 100% de los carácteres por el shift de la transposición o la correspondia de caracteres en scrambled

# Función para realizar la sustitución
substitute() {
    input_file=$1
    output_file=$2

    tr "$alphanumeric" "$scrambled" <"$input_file" >"$output_file"
}

# Función para realizar la sustitución inversa
reverse_substitute() {
    input_file=$1
    output_file=$2

    tr "$scrambled" "$alphanumeric" <"$input_file" >"$output_file"
}

# Función para realizar la transposición
transpose() {
    input_file=$1
    output_file=$2
    shift_amount=$3

    lower=$(echo {a..z} | sed -r 's/ //g')
    upper=$(echo {A..Z} | sed -r 's/ //g')
    shifted_lower=$(echo $lower | sed -r "s/(.{$shift_amount})(.*)/\2\1/")
    shifted_upper=$(echo $upper | sed -r "s/(.{$shift_amount})(.*)/\2\1/")

    tr "${lower}${upper}" "${shifted_lower}${shifted_upper}" < "$input_file" > "$output_file"
}

# Función para realizar la transposición inversa
reverse_transpose() {
    input_file=$1
    output_file=$2
    shift_amount=$3

    lower=$(echo {a..z} | sed -r 's/ //g')
    upper=$(echo {A..Z} | sed -r 's/ //g')
    shifted_lower=$(echo $lower | sed -r "s/(.{$shift_amount})(.*)/\2\1/")
    shifted_upper=$(echo $upper | sed -r "s/(.{$shift_amount})(.*)/\2\1/")

    tr "${shifted_lower}${shifted_upper}" "${lower}${upper}" < "$input_file" > "$output_file"
}

# Script principal
echo "Por favor, elige una operación:"
echo "1. Sustitución"
echo "2. Sustitución inversa"
echo "3. Transposición"
echo "4. Transposición inversa"
read -p "Introduce tu elección (1, 2, 3 o 4): " choice

if [[ $choice == 1 ]]; then
    read -p "Introduce la ruta del archivo de entrada: " input_file
    read -p "Introduce la ruta del archivo de salida: " output_file

    substitute "$input_file" "$output_file"
    echo "Sustitución completada. Archivo de salida: $output_file"

elif [[ $choice == 2 ]]; then
    read -p "Introduce la ruta del archivo de entrada: " input_file
    read -p "Introduce la ruta del archivo de salida: " output_file

    reverse_substitute "$input_file" "$output_file"
    echo "Sustitución inversa completada. Archivo de salida: $output_file"

elif [[ $choice == 3 ]]; then
    read -p "Introduce la cantidad de desplazamiento para la transposición: " shift_amount
    read -p "Introduce la ruta del archivo de entrada: " input_file
    read -p "Introduce la ruta del archivo de salida: " output_file

    transpose "$input_file" "$output_file" "$shift_amount"
    echo "Transposición completada. Archivo de salida: $output_file"

elif [[ $choice == 4 ]]; then
    read -p "Introduce la cantidad de desplazamiento para la transposición inversa: " shift_amount
    read -p "Introduce la ruta del archivo de entrada: " input_file
    read -p "Introduce la ruta del archivo de salida: " output_file

    reverse_transpose "$input_file" "$output_file" "$shift_amount"
    echo "Transposición inversa completada. Archivo de salida: $output_file"

else
    echo "Elección no válida. Por favor, inténtalo de nuevo."
fi