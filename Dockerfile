FROM cell/debsandbox
MAINTAINER Cell <maintainer.docker.cell@outer.systems>
ENV DOCKER_IMAGE="cell/catom"

ADD material/scripts    /usr/local/bin/
ADD material/payload    /opt/payload/
ADD material/profile.d  /etc/profile.d/
ADD material/skel       /etc/skel/
ENV DEFAULT_CMD="atom -w"

#atom
RUN apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -qy wget &&\
    apt-get clean -y && rm -rf /var/lib/apt/lists/* &&\
    wget -O /tmp/atom.deb --quiet https://atom.io/download/deb &&\
    dpkg -i /tmp/atom.deb &&\
    rm /tmp/atom.deb


