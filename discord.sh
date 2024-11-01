#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}Obteniendo la versión actual de Discord...${NC}"
version=$(timeout 0.5 discord --version | head -n 1 | grep -oP '\d+\.\d+\.\d+' 2>/dev/null)

if [ -z "$version" ]; then
  echo -e "${RED}Error: No se pudo obtener la versión de Discord.${NC}"
  exit 1
fi

echo -e "${GREEN}Versión actual obtenida: ${YELLOW}${version}${NC}"

major=$(echo $version | cut -d '.' -f 1)
minor=$(echo $version | cut -d '.' -f 2)
patch=$(echo $version | cut -d '.' -f 3)

echo -e "${CYAN}Incrementando el número de parche...${NC}"
new_patch=$((patch + 1))
echo -e "${GREEN}Nuevo número de parche: ${YELLOW}${new_patch}${NC}"

new_version="${major}.${minor}.${new_patch}"
echo -e "${CYAN}Nueva versión creada: ${YELLOW}${new_version}${NC}"

echo -e "${CYAN}Descargando la nueva versión...${NC}"
url="https://stable.dl2.discordapp.net/apps/linux/${new_version}/discord-${new_version}.deb"
curl -f -O "$url"

if [ $? -eq 0 ]; then
  echo -e "${GREEN}Nueva versión descargada: ${YELLOW}${new_version}${NC}"
  
  echo -e "${CYAN}Instalando la nueva versión...${NC}"
  sudo dpkg -i "discord-${new_version}.deb"
  
  if [ $? -eq 0 ]; then
    echo -e "${GREEN}¡Nueva versión de Discord instalada con éxito!${NC}"
  else
    echo -e "${RED}Error al instalar la nueva versión.${NC}"
  fi
else
  echo -e "${RED}Error: No se pudo descargar la versión ${new_version}. Es posible que aún no exista.${NC}"
fi

# Limpiar el archivo descargado si existe
rm -f "discord-${new_version}.deb"
