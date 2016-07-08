# Ubuntu image with gcloud-sdk and docker

FROM ubuntu:14.04
MAINTAINER Punit Agrawal

RUN apt-get update && apt-get install -y -qq --no-install-recommends wget unzip python php5-mysql php5-cli php5-cgi openssh-client python-openssl && apt-get clean
RUN apt-get install -y curl

# install gcloud-sdk and kubectl
ENV HOME /
RUN curl https://sdk.cloud.google.com | bash
ENV PATH google-cloud-sdk/bin:$PATH
RUN gcloud components install kubectl

# install docker
RUN apt-get install -y apt-transport-https ca-certificates
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" >> /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-engine
RUN apt-get clean && rm -rf /var/lib/apt-lists/*

CMD ["/bin/bash"]
