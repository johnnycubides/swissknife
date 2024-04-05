DOWNLOAD="https://github.com/DIGImend/digimend-kernel-drivers/releases/download/v12/digimend-dkms_12_all.deb"

install() {
	sudo apt install \
		dkms \
		-y
	wget -O digimend.deb $DOWNLOAD
	sudo dpkg -i digimend.deb
	rm digimend.deb
}

update() {
	sudo apt update
	install
}

help() {
	echo"
install
"
}

if [[ -v 1 ]]; then
	$1
else
	help
fi
