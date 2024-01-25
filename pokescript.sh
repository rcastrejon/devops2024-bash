#!/bin/bash

# Verificar si se proporcionó un parámetro
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 nombre_pokemon"
    exit 1
fi

# Usar curl para consultar la PokeAPI
respuesta=$(curl -s "https://pokeapi.co/api/v2/pokemon/$1")

# Verificar si el Pokémon existe
if echo "$respuesta" | jq -e . >/dev/null 2>&1; then
    # Usar jq para analizar los resultados e imprimir los datos
    nombre=$(echo "$respuesta" | jq -r '.name')
    nombre="${nombre^}"
    echo "$nombre (No. $(echo "$respuesta" | jq -r '.id'))"
    echo "Id = $(echo "$respuesta" | jq -r '.order')"
    echo "Weight = $(echo "$respuesta" | jq -r '.weight')"
    echo "Height = $(echo "$respuesta" | jq -r '.height')"
else
    echo "Nombre de Pokémon no válido. Por favor, inténtalo de nuevo con un nombre de Pokémon válido."
fi

