#!/bin/bash

# Build latest version of gixxi's development tools
# OS: Arch Linux

set -e

precond() {
  pacman -S git xclip sudo make supervisor curl wget git unzip pwgen tmux
}

precond

# install JDK 8

java8() {
  pacman -S jdk8-openjdk
  archlinux-java set java-8-openjdk
}

java8

# install leiningen

leiningen() {
  pacman -S clojure leiningen
}

leiningen

# install npm, bower and related stuff, yarn

js() {
    # yay -S nvm
    # set node 14
    # npm i -g yarn
}

js

# latex
tex() {
  pacman -S texlive-most
}

tex
