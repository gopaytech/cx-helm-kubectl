FROM ubuntu:bionic

WORKDIR /root/
ENV PATH="$PATH:/root/"
ENV HELM_VERSION=v2.14.3
ENV HELM_FILENAME=helm-${HELM_VERSION}-linux-amd64.tar.gz

RUN apt-get update \
 && apt-get install -y curl tar gzip gettext python python-pip git \
 && rm -rf /usr/local/bin/diff \
 && curl -L https://get.helm.sh/${HELM_FILENAME} | tar xz \
 && cp linux-amd64/helm /bin/helm && cp linux-amd64/helm /usr/local/bin/helm \
 && rm -rf linux-amd64 \
 && chmod +x /bin/helm \
 && chmod +x /usr/local/bin/helm

RUN mkdir -p ~/.aws
RUN echo "W2RlZmF1bHRdCnJlZ2lvbiA9IGFwLXNvdXRoZWFzdC0xCm91dHB1dCA9IGpzb24K" | base64 -d > ~/.aws/config

RUN pip install --no-cache-dir awscli

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl

RUN chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl


