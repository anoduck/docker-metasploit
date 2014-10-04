FROM ruby:1.9.3-p547

# Adds support for db_nmap
ENV NMAP_VERSION 6.47
	
RUN apt-get update && apt-get -y install bison \
	libbison-dev \
	libpcap-dev \
	libpcap0.8 \
	libpcap0.8-dev \
	postgresql-client \
	build-essential \
	wget \
	bzip2

RUN wget http://nmap.org/dist/nmap-${NMAP_VERSION}.tar.bz2 && \
	bzip2 -cd nmap-${NMAP_VERSION}.tar.bz2 | tar xvf - && \
	cd nmap-${NMAP_VERSION} && \
	./configure && \
	make && \
	make install && \
	cd && \
	rm -rf nmap-${NMAP_VERSION}
	

RUN git clone --depth=1 https://github.com/rapid7/metasploit-framework.git \
	&& cd metasploit-framework \
	&& bundle install

# TODO: Do some setup for dev env
ADD setup.sh /
WORKDIR /metasploit-framework
ADD pentest.rb /metasploit-framework/plugins/
CMD  ["/setup.sh"]
