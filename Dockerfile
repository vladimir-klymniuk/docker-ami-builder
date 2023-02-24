FROM python:2.7.15-stretch
MAINTAINER vladimir.klymniuk@gmail.com

# Version for Packages
ENV PACKER_VERSION 1.2.4
ENV PACKER_URL https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip
ENV PACKER_PACKAGE packer_${PACKER_VERSION}_linux_amd64.zip
ENV JQ_URL https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64

COPY requirements.txt /requirements.txt

RUN pip install -r /requirements.txt

RUN apt update && apt install unzip -y && curl -SsL -o /tmp/$PACKER_PACKAGE $PACKER_URL && \
        unzip /tmp/$PACKER_PACKAGE -d /tmp &&  mv /tmp/packer /usr/bin/ && \
        chmod 755 /usr/bin/packer && rm /tmp/$PACKER_PACKAGE && \
        curl -LS -o /usr/bin/jq ${JQ_URL} && chmod +x /usr/bin/jq && \
        apt-get clean && rm -rf /var/lib/apt/lists/*