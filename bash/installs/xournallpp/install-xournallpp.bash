dependencies() {
	sudo apt install \
		libportaudio2 libportaudiocpp0 libzip4 \
		-y
}

install() {
	wget https://github.com/xournalpp/xournalpp/releases/download/v1.2.3/xournalpp-1.2.3-Debian-bullseye-x86_64.deb

}
