FROM cell/debsandbox
MAINTAINER Cell <maintainer.docker.cell@outer.systems>
ENV DOCKER_IMAGE="cell/catom"

# Go
ENV GO_VERSION 1.7
RUN curl -sSL https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz | tar -C /usr/local -xz

## Tools
#RUN mkdir /tmp/go \
#	&& export \
#		GOPATH=/tmp/go \
#		GOBIN=/usr/local/go/bin \
#		PATH=${PATH}:/usr/local/go/bin &&\
#    echo godoc		&& go get golang.org/x/tools/cmd/godoc &&\
#    echo goimports	&& go get golang.org/x/tools/cmd/goimports &&\
#    echo oracle		&& go get golang.org/x/tools/cmd/oracle &&\
#    echo gorename	&& go get golang.org/x/tools/cmd/gorename &&\
#    echo gocode		&& go get github.com/nsf/gocode &&\
#    echo godef		&& go get github.com/rogpeppe/godef &&\
#    echo golint		&& go get github.com/golang/lint/golint &&\
#    echo errcheck	&& go get github.com/kisielk/errcheck &&\
#    echo gotags		&& go get github.com/jstemmer/gotags &&\
#    rm -r /tmp/go
RUN mkdir /tmp/go \
	&& export \
		GOPATH=/tmp/go \
		GOBIN=/usr/local/go/bin \
		PATH=${PATH}:/usr/local/go/bin &&\
	echo unconvert && go get github.com/mdempsky/unconvert &&\
	echo goconst && go get github.com/jgautheron/goconst/cmd/goconst &&\
	echo gocode && go get github.com/nsf/gocode &&\
	echo godef && go get github.com/rogpeppe/godef &&\
	echo gorename && go get golang.org/x/tools/cmd/gorename &&\
	echo dlv && go get github.com/derekparker/delve/cmd/dlv &&\
	echo gometalinter && go get github.com/alecthomas/gometalinter && gometalinter --install --update

# Atom
## libasound2 libgconf-2-4 libgnome-keyring-dev
## Dependancies
RUN apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -qy --no-install-recommends \
		wget \
		gconf2 gconf-service libgtk2.0-0 libnotify4 libxtst6 libnss3 python gvfs-bin xdg-utils libxss1 libxkbfile1 \
		libasound2 &&\
    apt-get clean -y && rm -rf /var/lib/apt/lists/*
## Atom itself
RUN wget -O /tmp/atom.deb --quiet https://atom.io/download/deb &&\
    dpkg -i /tmp/atom.deb &&\
    rm /tmp/atom.deb
## Directory to store embeded atom config
## Plugins
RUN export ATOM_HOME=/opt/payload/atom &&\
	apm install \
		autocomplete-go \
		gofmt \
		gometalinter-linter \
		navigator-godef \
		tester-go \
		gorename \
		go-config \
		go-get \
		linter \
		go-plus \
		builder-go \
		environment \
		navigation-history

# Material
ADD material/scripts    /usr/local/bin/
ADD material/payload    /opt/payload/
ADD material/profile.d  /etc/profile.d/
ENV DEFAULT_CMD="atom --foreground --add ."

