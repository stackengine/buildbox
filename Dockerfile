FROM oraclelinux:6.6
RUN yum install -y epel-release
RUN yum install -y docker-io wget 
RUN yum install -y bzr patch mercurial git sqlite-devel tar bash make ssh gcc

# download go 1.4.x needed for bootstrapping cloudflare 1.5 to /root/go1.4/
RUN curl -s https://storage.googleapis.com/golang/go1.4.3.linux-amd64.tar.gz | tar -vxz --xform 's|^go|go1.4|' -C /root
RUN mkdir -p /usr/local/src && cd /usr/local/src && git clone --branch go1.5.3-cloudflare1 https://github.com/cloudflare/go.git
RUN cd /usr/local/src/go/src && ./all.bash
RUN adduser stackengine
RUN mkdir -p /go/src/github.com/stackengine/controller && mkdir -p /go/{bin,pkg}
ENV GOPATH /go
ENV PATH /go/bin:/usr/local/src/go/bin:$PATH
WORKDIR /go/src/github.com/stackengine/controller
RUN chown stackengine:stackengine -R /go
USER stackengine
