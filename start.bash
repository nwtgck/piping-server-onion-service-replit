#! /bin/bash -xeu

# Piping Server version
VERSION=v1.7.0-2
# binary directory
BIN_DIR_PATH=$PWD/bin/$VERSION
BIN_PATH=$BIN_DIR_PATH/piping-server

# Make directory for bin
mkdir -p $BIN_DIR_PATH

# If bin is not found
if [ ! -f $BIN_PATH ]; then
  (
    # Go to the bin directory
    cd $BIN_DIR_PATH
    # Donwload
    curl -L https://github.com/nwtgck/piping-server-pkg/releases/download/${VERSION}/piping-server-pkg-linuxstatic-x64.tar.gz | tar xzvf -
    # Move
    mv piping-server-pkg-linuxstatic-x64/piping-server $BIN_PATH
    rm -r piping-server-pkg-linuxstatic-x64
  )
fi

mkdir -p /home/runner/psuedo_root/var/log/tor/
mkdir -p /home/runner/psuedo_root/var/lib/tor/hidden_service/
chmod 700 /home/runner/psuedo_root/var/lib/tor/hidden_service/

$BIN_PATH --http-port=8080 &
tor -f torrc &
wait
