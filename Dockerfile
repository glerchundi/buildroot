FROM ubuntu:12.04

# prerequisites
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
      git-core \
      vim \
      language-pack-en

# fix locale
ENV LANG en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
RUN locale-gen en_US && \
    update-locale LANG=$LANG LC_CTYPE=$LC_CTYPE

ENV BR_VERSION 2015.08-rc2.rev1
ADD https://github.com/glerchundi/buildroot/releases/download/v${BR_VERSION}/buildroot-${BR_VERSION}.tar.gz /tmp/buildroot.tar.gz
RUN tar xvfz /tmp/buildroot.tar.gz -C /tmp && ln -s /tmp/buildroot-${BR_VERSION} /tmp/buildroot

WORKDIR /tmp/buildroot
CMD [ "/bin/bash" ]
