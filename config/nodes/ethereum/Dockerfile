FROM ubuntu:latest

WORKDIR /root

# Do not keep bash history
ENV HISTFILE=/dev/null

# Add packages
RUN apt-get update -y
ENV PACKAGES="software-properties-common build-essential libtool autotools-dev autoconf libssl-dev libboost-all-dev"
RUN apt-get install -y $PACKAGES

RUN add-apt-repository -y ppa:ethereum/ethereum
RUN apt-get update -y
RUN apt-get install -y ethereum
RUN mkdir ./.ethereum/

RUN which geth
