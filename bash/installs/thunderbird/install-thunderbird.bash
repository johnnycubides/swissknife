SCRIPT_PATH=$(pwd)
APP=thunderbird
DP=~/gitPackages
DAPP=$DP/$APP

DOWNLOAD="https://download.mozilla.org/?product=thunderbird-115.9.0-SSL&os=linux64&lang=es-ES"

install() {
	rm -rf $DAPP
	sudo rm /usr/local/bin/$APP
	mkdir -p $DAPP
	cd $DAPP
	wget -O $APP.tar.bz2 $DOWNLOAD
	tar xvjf $APP.tar.bz2
	rm -f $APP.tar.bz2
	cd $APP
	sudo ln -sr $APP /usr/local/bin/$APP
}

desktop-file() {

	PATH_LOGO=$DAPP/thunderbird/chrome/icons/default/default128.png
	RESOURCE_NAME=thunderbird

	cd $SCRIPT_PATH

	TMP_DIR=$(mktemp --directory)

	sed -e "s,<EXEC_LOCATION>,thunderbird,g" \
		-e "s,<ICON_LOCATION>,${PATH_LOGO},g" "${SCRIPT_PATH}/linux/desktop.template" >"${TMP_DIR}/${RESOURCE_NAME}.desktop"

	mkdir -p "${HOME}/.local/share/applications"
	cp "${TMP_DIR}/${RESOURCE_NAME}.desktop" "${HOME}/.local/share/applications/"

	mkdir -p "${HOME}/.local/share/mime/packages"
	cp "${SCRIPT_PATH}/linux/${RESOURCE_NAME}.xml" "${HOME}/.local/share/mime/packages"

	rm "${TMP_DIR}/${RESOURCE_NAME}.desktop"
	rmdir "${TMP_DIR}"

	if [ -d "${HOME}/.local/share/applications" ]; then
		if command -v update-desktop-database >/dev/null; then
			update-desktop-database "${HOME}/.local/share/applications"
		fi
	fi

	if [ -d "${HOME}/.local/share/mime" ]; then
		if command -v update-mime-database >/dev/null; then
			update-mime-database "${HOME}/.local/share/mime"
		fi
	fi
}

help() {
	echo "
remove-firefox-esr
install
desktop-file
update-firefox
  "
}

if [[ -v 1 ]]; then
	$1
else
	help
fi
