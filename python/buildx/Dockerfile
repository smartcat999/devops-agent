FROM 2030047311/builder-base:dev-v3.3.1-buildx

# python3
ENV PYTHON_VERSION=3.7.11
RUN apt-get install -y bzip2 libffi-dev libsqlite3-dev libssl-dev && \
    curl -fSL https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz -o /usr/src/Python-${PYTHON_VERSION}.tgz && \
    tar xzf /usr/src/Python-${PYTHON_VERSION}.tgz -C /usr/src/ --no-same-owner && \
    cd /usr/src/Python-${PYTHON_VERSION} && \
    ./configure --enable-optimizations --with-ensurepip=install --enable-loadable-sqlite-extensions && \
    make altinstall -j 2 && \
    cd ../ && \
    rm -rf /usr/src/Python-${PYTHON_VERSION}.tgz /usr/src/Python-${PYTHON_VERSION} && \
    ln -fs /usr/local/bin/python3.7 /usr/bin/python && \
    ln -fs /usr/local/bin/python3.7 /usr/bin/python3 && \
    ln -fs /usr/local/bin/pip3.7 /usr/bin/pip && \
    python3 -m pip install --upgrade pip && \
    apt remove -y bzip2 libffi-dev libsqlite3-dev && \
    apt-get clean

CMD ["python","--version"]
