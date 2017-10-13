FROM ubuntu:latest
MAINTAINER Rodney Hawkins

RUN apt-get update && apt-get install -y -qq --no-install-recommends curl python openssh-client python-openssl python-pip apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    ansible

# Install gcloud-sdk and kubectl
ENV HOME /
RUN curl https://sdk.cloud.google.com | bash
ENV PATH google-cloud-sdk/bin:$PATH
RUN gcloud components install kubectl

# Install Docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
RUN apt-get update && apt-get install docker-ce
RUN apt-get clean && rm -rf /var/lib/apt-lists/*

RUN pip install docker-compose

CMD ["/bin/bash"]
