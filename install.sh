#!/bin/bash

# Build latest version of gixxi's development tools, version management with stow
# OS: Elementary OS

set -e

#purge docker
docker_purge() {
	apt-get purge lxc-docker* docker.io*
} 

# docker_purge || true

#install docker
# curl -sSL https://get.docker.com/ | sh

precond() {
  locale-gen en_US.UTF-8 && \
    echo 'LANG="en_US.UTF-8"' > /etc/default/locale && \
    sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
    apt-get install -y --force-yes git xclip sudo ftp ftp-upload make supervisor build-essential software-properties-common apt-transport-https curl wget git unzip pwgen tmux
}

#precond

# install JDK 8

java8_x64() {
	#wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u91-b14/jdk-8u91-linux-x64.tar.gz && \
	#mkdir -p /opt/jdk && \
	#tar -zxf jdk-8u91-linux-x64.tar.gz -C /opt/jdk && \
	#rm jdk-8u91-linux-x64.tar.gz && \
        update-alternatives --remove-all java
        update-alternatives --remove-all javac
        update-alternatives --install /usr/bin/java java /opt/jdk/jdk1.8.0_91/bin/java 100 && \
          update-alternatives --install /usr/bin/javac javac /opt/jdk/jdk1.8.0_91/bin/javac 100
}

#java8_x64

java8_x86() {
	wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u91-b14/jdk-8u91-linux-i586.tar.gz && \
        mkdir -p /opt/jdk-i586 && \
	tar -zxf jdk-8u91-linux-i586.tar.gz -C /opt/jdk-i586 && \
	rm jdk-8u91-linux-i586.tar.gz && \
        update-alternatives --remove-all java-i586
        update-alternatives --remove-all javac-i586
	update-alternatives --install /usr/bin/java-i586 java-i586 /opt/jdk-i586/jdk1.8.0_91/bin/java 100 && \
	  update-alternatives --install /usr/bin/javac-i586 javac-i586 /opt/jdk-i586/jdk1.8.0_91/bin/javac 100
}

#java8_x86

# install JDK 9
java9_x64() {
    jdk-9+181_linux-x64_bin.tar.gz \
    mkdir -p /opt/jdk && mkdir -p /opt/jdk/x64 && \
    tar -zxf jdk-9+181_linux-x64_bin.tar.gz -C /opt/jdk/x64 && \
    rm jdk-9+181_linux-x64_bin.tar.gz && \
    update-alternatives --install /usr/bin/java java /opt/jdk/x64/jdk-9/bin/java 100 && \
    update-alternatives --install /usr/bin/javac javac /opt/jdk/x64/jdk-9/bin/javac 100
}

#java9_x64

# install JDK 9
java9_x86() {
    wget http://download.java.net/java/GA/jdk9/9/binaries/jdk-9+181_linux-x86_bin.tar.gz && \
    mkdir -p /opt/jdk && mkdir -p /opt/jdk/x86 && \
    tar -zxf jdk-9+181_linux-x86_bin.tar.gz -C /opt/jdk/x86 && \
    rm jdk-9+181_linux-x86_bin.tar.gz && \
    update-alternatives --install /usr/bin/java-i586 java-i586 /opt/jdk/x86/jdk-9/bin/java 100 && \
    update-alternatives --install /usr/bin/javac-i586 javac-i586 /opt/jdk/x86/jdk-9/bin/javac 100
}

#java9_x86

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

# install couchdb

couchdb() {
  DEBIAN_FRONTEND=noninteractive \
                 apt-get install -y g++ && \
    apt-get install -y erlang-dev erlang-manpages erlang-base-hipe erlang-eunit erlang-nox erlang-xmerl erlang-inets && \
    apt-get install -y libmozjs185-dev libicu-dev libcurl4-gnutls-dev libtool
    	cd /tmp && \
    	wget http://mirror.switch.ch/mirror/apache/dist/couchdb/source/1.6.1/apache-couchdb-1.6.1.tar.gz && \
    	tar xzvf apache-couchdb-1.6.1.tar.gz && \
    	cd apache-couchdb-1.6.1 && \
    	./configure && \
    	make && \
    	make install && \

  ### remove leftovers from ubuntu packages
  rm -f /etc/logrotate.d/couchdb /etc/init.d/couchdb

  ### install logrotate and initd scripts
  sudo ln -s /usr/local/etc/logrotate.d/couchdb /etc/logrotate.d/couchdb
  ln -s /usr/local/etc/init.d/couchdb  /etc/init.d
  update-rc.d couchdb defaults

  curl http://127.0.0.1:5984/
}

#couchdb


# install npm, bower and related stuff

js() {
  apt-get update && \
    apt-get install -y --force-yes npm && \
    npm install -g bower msx less && \
    ln -s /usr/bin/nodejs /usr/bin/node
}

js

# latex
tex() {
  apt-get install -y --force-yes texlive texlive-latex-base texlive-latex-extra
}

tex
