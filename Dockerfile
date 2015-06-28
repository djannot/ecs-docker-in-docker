FROM jpetazzo/dind
COPY *.crt /usr/local/share/ca-certificates/
RUN apt-get install -y xfsprogs
ADD . /
