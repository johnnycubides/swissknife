#!/bin/bash

install() {
	sudo apt update
	sudo apt install \
		librecad \
		-y
}

install
