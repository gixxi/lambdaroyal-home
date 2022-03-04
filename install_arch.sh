#!/bin/bash

# Build latest version of gixxi's development tools
# OS: Arch Linux

set -e

precond() {
  pacman -S --needed --noconfirm git xclip sudo make supervisor curl wget git unzip pwgen tmux
}

precond

# install JDK 8

java8() {
  pacman -S --needed --noconfirm jdk8-openjdk
  archlinux-java set java-8-openjdk
}

java8

# install leiningen

leiningen() {
  pacman -S --needed --noconfirm clojure leiningen
}

leiningen

# install npm, bower and related stuff, yarn

js() {
  echo "install node with nvm"
  # yay -S --needed --noconfirm nvm
  # nvm install 14
  # npm i -g yarn
}

js

# latex

tex() {
  pacman -S --needed --noconfirm texlive-most
}

tex
