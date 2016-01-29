FROM oraclelinux:6.6
# on centos, yum install -y epel-release
# but on oraclelinux
RUN yum install -y http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

RUN yum install -y docker-io wget 
RUN yum install -y bzr patch s3cmd mercurial git sqlite-devel tar bash make ssh gcc

# download go 1.4.x needed for bootstrapping cloudflare 1.5 to /root/go1.4/
RUN curl -s https://storage.googleapis.com/golang/go1.4.3.linux-amd64.tar.gz | tar -vxz --xform 's|^go|go1.4|' -C /root
RUN mkdir -p /usr/local/src && cd /usr/local/src && git clone --branch go1.5.3-cloudflare1 https://github.com/cloudflare/go.git
RUN cd /usr/local/src/go/src && ./all.bash

# patch bzr's python lib, it has issues https://bugzilla.redhat.com/show_bug.cgi?id=1253897
COPY bzr.patch /usr/lib64/python2.6/site-packages/bzr.patch
RUN patch -d /usr/lib64/python2.6/site-packages -p0 < /usr/lib64/python2.6/site-packages/bzr.patch

RUN adduser stackengine
RUN mkdir -p /go/src/github.com/stackengine/controller && mkdir -p /go/{bin,pkg}
ENV GOPATH /go
ENV PATH /go/bin:/usr/local/src/go/bin:$PATH
WORKDIR /go/src/github.com/stackengine/controller
RUN chown stackengine:stackengine -R /go
USER stackengine
