
: "${GOPATH:="$WORKDIR"}"
: "${GOBIN:="$WORKDIR"}"
: "${ATOM_HOME:="$WORKDIR/.atom"}"
PATH=${PATH}:/usr/local/go/bin:${GOBIN}
export GOPATH GOBIN ATOM_HOME PATH

if [ ! -d "$ATOM_HOME" ]; then
	#echo "ATOM_HOME:$ATOM_HOME WORKDIR:$WORKDIR GOPATH:$GOPATH"
	cp -r /opt/payload/atom $ATOM_HOME
	chown -R ${USER}. $ATOM_HOME
fi

