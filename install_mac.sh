#!/bin/bash

# Build latest version of gixxi's development tools, version management with stow
# OS: Elementary OS

set -e

precond() {
  brew install git xclip lftp make curl wget pwgen tmux
}

precond

# install OpenJDK 8

java8_x64() {
  brew tap AdoptOpenJDK/openjdk
  brew cask install adoptopenjdk8
}

java8_x64

# install leiningen

leiningen() {
  brew install leiningen
}

leiningen

# install node, yarn and less

js() {
    brew install node
    wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo
    brew install yarn
    yarn config set prefix /opt/yarn
    yarn global add less
    ln -s /opt/yarn/bin/lessc /usr/local/bin/lessc
}

js

# latex

tex() {
  brew install --cask mactex
}

tex
