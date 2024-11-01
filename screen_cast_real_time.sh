#!/bin/bash

# Configuración
TEMP_FILE="screen_recording_tmp.mkv" # archivo temporal donde se guarda la grabación
SEGMENT_TIME=10 # duración de cada segmento en segundos

# Función para limpiar archivos temporales al salir
cleanup() {
    echo "Limpiando archivos temporales..."
    rm -f "$TEMP_FILE"
}
trap cleanup EXIT

# Iniciar mkchromecast en segundo plano leyendo del archivo de grabación
echo "Iniciando mkchromecast..."
mkchromecast -i "$TEMP_FILE" & # Puedes añadir aquí cualquier opción de mkchromecast que necesites
MKCHROMECAST_PID=$!

# Iniciar la grabación con ffmpeg en un loop segmentado
echo "Iniciando grabación con ffmpeg..."
ffmpeg -y -f x11grab -video_size 1920x1080 -framerate 25 -i :0.0 \
       -c:v libx264 -preset ultrafast -f matroska -t $SEGMENT_TIME \
       "$TEMP_FILE" &

FFMPEG_PID=$!

# Mantener el script activo mientras mkchromecast y ffmpeg estén ejecutándose
wait $FFMPEG_PID
wait $MKCHROMECAST_PID

echo "Finalizado."
