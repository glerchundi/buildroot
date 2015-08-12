FROM ubuntu:12.04

RUN echo "locales locales/locales_to_be_generated multiselect en_US.UTF-8 UTF-8" | debconf-set-selections && \
    echo "locales locales/default_environment_locale select en_US.UTF-8" | debconf-set-selections && \
    apt-get -q update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -q -y \
      wget \
      build-essential \
      libncurses-dev \
      rsync \
      unzip \
      bc \
      gnupg \
      python \
      libc6-i386 \
      cpio \
      locales \
      git-core

ENV BR_VERSION 2015.05.rev1
ADD https://github.com/glerchundi/buildroot/releases/download/v${BR_VERSION}/buildroot-${BR_VERSION}.tar.gz /tmp/buildroot.tar.gz
RUN tar xvfz /tmp/buildroot.tar.gz -C /tmp

WORKDIR /tmp/buildroot-${BR_VERSION}
CMD [ "/bin/bash" ]