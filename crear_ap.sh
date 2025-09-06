#!/bin/bash

# CONFIGURACIÓN
INTERNET_IFACE="wlan0"      # interfaz con conexión a Internet
AP_IFACE="wlan1"            # interfaz que transmitirá el AP
SSID="MiPuntoWifi"
PASSWORD="clave1234"
SUBNET="192.168.50"

# INSTALA DEPENDENCIAS

sudo apt install -y hostapd dnsmasq iptables

# DETIENE SERVICIOS TEMPORALMENTE
sudo systemctl stop hostapd
sudo systemctl stop dnsmasq

# CONFIGURA IP ESTÁTICA PARA EL AP
sudo ip link set $AP_IFACE down
sudo ip addr flush dev $AP_IFACE
sudo ip addr add $SUBNET.1/24 dev $AP_IFACE
sudo ip link set $AP_IFACE up

# CONFIGURA dnsmasq
echo "
interface=$AP_IFACE
dhcp-range=$SUBNET.10,$SUBNET.100,255.255.255.0,24h
" | sudo tee /etc/dnsmasq.conf

# CONFIGURA hostapd
echo "
interface=$AP_IFACE
driver=nl80211
ssid=$SSID
hw_mode=g
channel=6
wmm_enabled=0
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=$PASSWORD
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP
" | sudo tee /etc/hostapd/hostapd.conf

# HABILITA EL ENRUTAMIENTO Y NAT
sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -t nat -A POSTROUTING -o $INTERNET_IFACE -j MASQUERADE
sudo iptables -A FORWARD -i $INTERNET_IFACE -o $AP_IFACE -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i $AP_IFACE -o $INTERNET_IFACE -j ACCEPT

# GUARDA LAS REGLAS IPTABLES (opcional)
sudo sh -c "iptables-save > /etc/iptables.rules"

# INICIA LOS SERVICIOS
sudo systemctl start dnsmasq
sudo systemctl start hostapd

echo "✅ Punto de acceso creado: SSID '$SSID', contraseña '$PASSWORD'"
