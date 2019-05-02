#!/bin/bash
link_firefox="https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US"
link_developer_firefox="https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US"

cd ~/Downloads/
wget -O firefox_developer.tar.bz2 "$link_developer_firefox"
sudo tar xjvf firefox_developer.tar.bz2 -C /opt/
rm firefox_developer.tar.bz2
