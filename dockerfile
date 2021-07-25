# Base image
FROM ubuntu:20.04

# Labels and Credits
LABEL \
    name="Webdocker" \
    author="Rahul Kadavil <rahulkadavl@gmail.com>" \
    description="Docker image containing tools for recon and web app testing"

# Environment vars
ENV DEBIAN_FRONTEND="noninteractive" \
    ANALYZER_IDENTIFIER="" \
    JDK_FILE="openjdk-16.0.1_linux-x64_bin.tar.gz" \
    JDK_FILE_ARM="openjdk-16.0.1_linux-aarch64_bin.tar.gz" \
    JAVA_HOME="/jdk-16.0.1" \
    PATH="$JAVA_HOME/bin:$PATH"

# See https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#run
RUN apt update -y && apt install -y  --no-install-recommends \
    build-essential \
    wget \
    software-properties-common

RUN add-apt-repository ppa:longsleep/golang-backports && apt update -y && apt install -y \
    golang-go

RUN go get -u github.com/tomnomnom/assetfinder 
RUN go get -u github.com/tomnomnom/httprobe
RUN go get -v github.com/projectdiscovery/httpx/cmd/httpx 
RUN go get -v github.com/OWASP/Amass/v3/ 
RUN go get -u -v github.com/lc/gau
RUN go get -u github.com/ffuf/ffuf
RUN go get -u github.com/tomnomnom/waybackurls
RUN go get -u github.com/tomnomnom/meg
RUN go get -u github.com/michenriksen/aquatone

RUN echo "export PATH=$PATH:/root/go/bin" >> ~/.bashrc
