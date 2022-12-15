# dotfiles


### fix wsl2 resolv.conf
```sh
sudo rm /etc/resolv.conf
sudo bash -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf'
sudo bash -c 'echo "[network]" > /etc/wsl.conf'
sudo bash -c 'echo "generateResolvConf = false" >> /etc/wsl.conf'
sudo chattr +i /etc/resolv.conf
```

### font download
```
sudo apt install fontconfig unzip
mkdir ~/.fonts && cd ~/.fonts
wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/FiraMono.zip"
unzip FiraMono.zip
fc-cache -fv
```
