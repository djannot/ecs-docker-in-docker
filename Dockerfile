FROM jpetazzo/dind
RUN apt-get install -y xfsprogs
ADD . /
