FROM pandrew/kali

MAINTAINER Paul Andrew Liljenberg "letters@paulnotcom.se"

RUN DEBIAN_FRONTED=noninteractive apt-get -y install metasploit
