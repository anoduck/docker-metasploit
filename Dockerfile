FROM ruby:1.9.3-p547

RUN apt-get update && apt-get -y install bison \
	libbison-dev \
	libpcap-dev \
	libpcap0.8 \
	libpcap0.8-dev \
	postgresql-client-common

# TODO: Needs bootstrapping of remote/linked database

RUN git clone --depth=1 https://github.com/rapid7/metasploit-framework.git \
	&& cd metasploit-framework \
	&& bundle install

# TODO: Do some setup for dev env
WORKDIR /metasploit-framework
CMD  ["/metasploit-framework/msfconsole"]
