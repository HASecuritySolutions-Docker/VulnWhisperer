FROM ubuntu:18.04

MAINTAINER Justin Henderson justin@hasecuritysolutions.com

RUN apt update \
    && echo "debconf debconf/frontend select noninteractive" | debconf-set-selections \
    && apt install -y build-essential python python-pip zlib1g-dev libxml2-dev libxslt1-dev git  \
    && mkdir /opt/vulnwhisperer \
    && cd /opt/vulnwhisperer \
    && git clone https://github.com/HASecuritySolutions/VulnWhisperer.git . \
    && pip install --upgrade pip setuptools \
    && pip install -r requirements.txt \
    && python setup.py install \
    && echo "LC_ALL=C.UTF-8" >> /etc/profile \
    && apt clean -y
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

STOPSIGNAL SIGTERM
CMD  vuln_whisperer -c /opt/vulnwhisperer/configs/flare.ini
