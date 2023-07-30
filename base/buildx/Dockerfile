FROM ubuntu:20.04

ENV TZ=Asia/Shanghai \
    DEBIAN_FRONTEND=noninteractive

# utils
RUN apt update && apt-get install -y ca-certificates && \
  apt-get install -y unzip \
  make \
  wget \
  zip \
  bzip2 \
  gcc \
  g++ \
  curl \
  autoconf \
  expat \
  gettext \
  openssl \
  perl \
  zlib1g \
  python3-pip \
  openjdk-8-jdk-headless  \
  gnupg \
  locales && \
  locale-gen en_US.UTF-8 && \
  dpkg-reconfigure locales && \
  apt-get clean

RUN wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.9.5.tar.gz && \
    tar zxvf git-2.9.5.tar.gz --no-same-owner && \
    cd git-2.9.5 && \
    make configure && \
    ./configure prefix=/usr/local/git/ && \
    make && \
    make install && \
    mv /usr/local/git/bin/git /usr/bin/ && \
    cd .. && \
    rm -rf git-2.9.5.tar.gz git-2.9.5 && \
    git version

# Set the locale(en_US.UTF-8)
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# USER jenkins
WORKDIR /home/jenkins

ENV SONAR_SCANNER_VERSION 3.3.0.1492

RUN curl -o sonar_scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip && \
    unzip sonar_scanner.zip && rm sonar_scanner.zip \
    && rm -rf sonar-scanner-$SONAR_SCANNER_VERSION-linux/jre && \
    sed -i 's/use_embedded_jre=true/use_embedded_jre=false/g' /home/jenkins/sonar-scanner-$SONAR_SCANNER_VERSION-linux/bin/sonar-scanner && \
    mv /home/jenkins/sonar-scanner-$SONAR_SCANNER_VERSION-linux /usr/bin

ENV PATH $PATH:/usr/bin/sonar-scanner-$SONAR_SCANNER_VERSION-linux/bin

COPY ./ ./

ENV EXCLUDE_DOCKER 1
RUN ./hack/install_utils.sh && rm -rf ./*

# Install docker
RUN install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    chmod a+r /etc/apt/keyrings/docker.gpg && \
    echo \
      "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
      tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin && \
    apt-get clean

COPY storage.conf /etc/containers/storage.conf
COPY containers.conf /etc/containers/containers.conf

VOLUME /var/lib/containers

CMD ["docker", "info"]
