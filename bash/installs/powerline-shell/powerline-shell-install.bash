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

# dependencies
install
