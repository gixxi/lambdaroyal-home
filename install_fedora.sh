#!/bin/bash

# Build latest version of gixxi's development tools, version management with stow
# OS: Elementary OS

set -e

precond() {
  dnf install -y git xclip sudo ftp make supervisor curl wget git unzip pwgen tmux
}

precond

# install JDK 8

java8_x64() {
        wget --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-x64.tar.gz"
	mkdir -p /opt/jdk
	tar -zxf jdk-8u161-linux-x64.tar.gz -C /opt/jdk
	rm jdk-8u161-linux-x64.tar.gz
        update-alternatives --remove-all java
        update-alternatives --remove-all javac
        update-alternatives --install /usr/bin/java java /opt/jdk/jdk1.8.0_161/bin/java 100
        update-alternatives --install /usr/bin/javac javac /opt/jdk/jdk1.8.0_161/bin/javac 100
}

java8_x64

java8_x86() {
        wget --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-i586.tar.gz"
        mkdir -p /opt/jdk-i586
	tar -zxf jdk-8u161-linux-i586.tar.gz -C /opt/jdk-i586
	rm jdk-8u161-linux-i586.tar.gz
        update-alternatives --remove-all java-i586
        update-alternatives --remove-all javac-i586
	update-alternatives --install /usr/bin/java-i586 java-i586 /opt/jdk-i586/jdk1.8.0_161/bin/java 100
	update-alternatives --install /usr/bin/javac-i586 javac-i586 /opt/jdk-i586/jdk1.8.0_161/bin/javac 100
}

java8_x86

# install JDK 9
java9_x64() {
  wget --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/9.0.4+11/c2514751926b4512b076cc82f959763f/jdk-9.0.4_linux-x64_bin.tar.gz"
  mkdir -p /opt/jdk && mkdir -p /opt/jdk/x64
  tar -zxf jdk-9.0.4_linux-x64_bin.tar.gz -C /opt/jdk/x64
  rm jdk-9.0.4_linux-x64_bin.tar.gz
  update-alternatives --remove-all java9
  update-alternatives --remove-all javac9
  update-alternatives --install /usr/bin/java9 java9 /opt/jdk/x64/jdk-9.0.4/bin/java 100
  update-alternatives --install /usr/bin/javac9 javac9 /opt/jdk/x64/jdk-9.0.4/bin/javac 100
}

java9_x64

# install leiningen

leiningen() {
  home=~
  mkdir -p ~/bin
	wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -O ~/bin/lein && \
	chmod a+x ~/bin/lein && \
	export PATH=$PATH:$HOME/bin && \
	bash lein
}

leiningen

# install npm, bower and related stuff, yarn

js() {
    curl --silent --location https://rpm.nodesource.com/setup_9.x | bash -
    dnf install -y nodejs
    wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo
    dnf install yarn
    yarn config set prefix /opt/yarn
    dnf install v8
    yarn global add less
    ln -s /opt/yarn/bin/lessc /usr/local/bin/lessc
}

js

# latex
tex() {
  dnf install -y texlive texlive-scheme-full
}

tex
