DP=~/gitPackages

dependencies() {
	sudo apt update
	sudo apt install python3-setuptools fonts-powerline -y
}

install() {
	cd $DP
	git clone https://github.com/b-ryan/powerline-shell.git
	cd powerline-shell
	sudo python3 setup.py install --record files.txt
	cd ..
	sudo rm -rf powerline-shell
}

config_laptop() {
	mkdir -p ~/.config/powerline-shell/
	cp ./config_laptop.json ~/.config/powerline-shell/config.json
}

config_desktop() {
	mkdir -p ~/.config/powerline-shell/
	cp ./config_desktop.json ~/.config/powerline-shell/config.json
}

bash_config() {
	cat ./bashrc_powerline_shell.bash >>~/.bashrc
}

# dependencies
# install
# config_laptop
# config_desktop
# bash_config # Esta configuracion se debe realizar una unica vez

help() {
	echo "
dependencies
install
config_laptop
config_desktop
bash_config # Esta configuracion se debe realizar una unica vez
  "
}

if [[ -v 1 ]]; then
	$1
else
	help
fi
