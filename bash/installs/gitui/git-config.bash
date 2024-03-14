#!/bin/bash

config() {
	git config --global user.name "Johnny Cubides"
	git config --global user.email jgcubidesc@gmail.com
	git config --list
}

config
