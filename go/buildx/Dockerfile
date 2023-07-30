FROM 2030047311/builder-base:dev-v3.3.1-buildx

RUN apt-get install build-essential && apt-get clean

ARG GOLANG_VERSION=1.18.10
ENV GOLANG_VERSION $GOLANG_VERSION

ENV PATH $PATH:/usr/local/go/bin
ENV PATH $PATH:/usr/local/
ENV GOROOT /usr/local/go
ENV GOPATH=/home/jenkins/go
ENV PATH $PATH:$GOPATH/bin

COPY ./ ./
RUN ./hack/install_utils.sh && rm -rf ./*

RUN mkdir -p $GOPATH/bin && mkdir -p $GOPATH/src && mkdir -p $GOPATH/pkg

CMD ["go","version"]
