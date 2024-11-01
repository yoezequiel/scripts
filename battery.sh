#!/bin/bash

get_battery_info() {
    # Obtener información de la batería
    battery_info=$(upower -i $(upower -e | grep 'BAT'))

    # Extraer el porcentaje
    porcentaje=$(echo "$battery_info" | grep "percentage" | awk '{print $2}')

    # Extraer el estado
    estado=$(echo "$battery_info" | grep "state" | awk '{print $2}')

    # Asignar símbolo según el estado
    if [ "$estado" == "charging" ]; then
        estado_simbolo="↑"
    elif [ "$estado" == "discharging" ]; then
        estado_simbolo="↓"
    else
        estado_simbolo=""
    fi

    # Enviar la notificación
    notify-send "Batería" "$porcentaje $estado_simbolo"
}

get_battery_info
