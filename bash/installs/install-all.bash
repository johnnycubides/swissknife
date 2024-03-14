GITUI_VERSION=0.25.1

sudo apt update
sudo apt install git -y

mkdir -p ~/gitPackges/ && cd ~/gitPackages
wget -O "gitui.tar.gz" "https://github.com/extrawurst/gitui/releases/download/$GITUI_VERSION/gitui-linux-musl.tar.gz"
tar xvf gitui.tar.gz
chmod +x gitui
ln -sr ./gitui /usr/local/bin
