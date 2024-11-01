sudo apt update
sudo apt upgrade -y
sudo apt install kitty zsh htop neofetch rofi git blueman gnome-keyring -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -y
sudo apt purge gnome* kde* debian-reference* discover* synaptic* xterm* xfce4-dict* atril* parole* exfalso* libreoffice* ristretto* xsane* xarchiver* mousepad* thunar* firefox* xfburn* xfce4-clipman* xfce4-panel* xfce4-terminal* xfce4-weather-plugin:amd64* xfce4-whiskermenu-plugin:amd64* vlc* w3m* -y
chsh -s /bin/zsh yoezequiel
chsh -s /bin/zsh root


sudo apt install curl -y
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser -y

sudo apt autoremove -y