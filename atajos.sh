#!/bin/bash

# Ruta del archivo de atajos de teclado
SHORTCUTS_FILE="$HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml"

# Crea una copia de seguridad del archivo original

# Agrega la línea justo debajo de <property name="custom" type="empty">
sed -i '/<property name="custom" type="empty">/a \
      <property name="<Super>b" type="string" value="./scripts/battery.sh"/>' "$SHORTCUTS_FILE"
      <property name="&lt;Super&gt;BackSpace" type="string" value="./.config/rofi/scripts/powermenu_t2"/>
      <property name="&lt;Super&gt;space" type="string" value="./.config/rofi/scripts/launcher_t1"/>
      <property name="&lt;Super&gt;h" type="string" value="./scripts/time.sh"/>
      <property name="AudioLowerVolume" type="string" value="amixer sset Master 10%- "/>
      <property name="AudioRaiseVolume" type="string" value="amixer sset Master 10%+ "/>
      <property name="AudioMute" type="string" value="amixer sset Master toggle "/>
      <property name="Launch1" type="string" value="./scripts/mic.sh"/>
