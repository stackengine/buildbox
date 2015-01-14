FROM centos:centos6
RUN yum install -y epel-release
RUN sed -i 's/https/http/' /etc/yum.repos.d/epel.repo
RUN yum install -y docker-io wget 
RUN wget http://s3tools.org/repo/RHEL_6/s3tools.repo -O /etc/yum.repos.d/s3tools.repo
RUN yum install -y s3cmd mercurial git sqlite-devel tar bash make ssh gcc
RUN wget https://storage.googleapis.com/golang/go1.3.1.linux-amd64.tar.gz 
RUN tar -C /usr/local -xzf go1.3.1.linux-amd64.tar.gz
RUN mkdir -p /go/src/github.com/stackengine/controller && mkdir -p /go/{bin,pkg}
ENV GOPATH=/go
ENV PATH=/go/bin:/usr/local/go/bin:$PATH
WORKDIR /go/src/github.com/stackengine/controller

