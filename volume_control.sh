#!/bin/bash

# Variable global para el ID de la notificación
NOTIFY_ID=1000  # ID único para las notificaciones de volumen

# Función para mostrar notificación con el volumen actual
show_notification() {
    # Obtener el estado de mute y el volumen actual
    is_muted=$(amixer get Master | grep '\[off\]' > /dev/null && echo 1 || echo 0)
    volume=$(amixer get Master | grep -oP '\d+%' | head -1 | tr -d '%')
    
    if [ "$is_muted" -eq 1 ]; then
        # Mostrar notificación de mute
        notify-send -u low -t 1500 -r $NOTIFY_ID "Volumen: MUTE" "❌ Silenciado" --icon=audio-volume-muted
    else
        # Calcular número de bloques llenos (10 bloques en total)
        filled=$(( (volume + 5) / 10 ))  # Redondeo para evitar barras incompletas
        empty=$((10 - filled))

        # Crear la barra de progreso
        bar=$(printf '█%.0s' $(seq 1 $filled))
        empty_bar=$(printf '░%.0s' $(seq 1 $empty))

        # Mostrar notificación con el volumen y la barra
        notify-send -u low -t 1500 -r $NOTIFY_ID "Volumen: $volume%" "$bar$empty_bar" --icon=audio-volume-high
    fi
}

# Comprobar el argumento
case $1 in
    up)
        # Subir volumen
        amixer sset Master 10%+ > /dev/null
        ;;
    down)
        # Bajar volumen
        amixer sset Master 10%- > /dev/null
        ;;
    mute)
        # Silenciar/activar volumen
        amixer sset Master toggle > /dev/null
        ;;
    *)
        echo "Uso: $0 {up|down|mute}"
        exit 1
        ;;
esac

# Mostrar notificación
show_notification
