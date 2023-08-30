#! /bin/bash -e

# Piping Server version
VERSION=v1.12.9
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

if [[ -z "${HS_ED25519_SECRET_KEY_BASE64}" ]]; then
  echo "WARN: \$HS_ED25519_SECRET_KEY_BASE64 is not defined"
  echo "INFO: See 'Host persistency' section in README to persistent host"
else
  # NOTE: public_key and hostname are automatically generated from the private key
  echo "${HS_ED25519_SECRET_KEY_BASE64}" | base64 -d > /home/runner/psuedo_root/var/lib/tor/hidden_service/hs_ed25519_secret_key

  unset HS_ED25519_SECRET_KEY_BASE64;
fi


trap 'kill $(jobs -p)' EXIT

# (
#   while :
#   do
#    echo "Starting Piping Server..."
#    kill $(lsof -t -i:8080 -sTCP:LISTEN) || true
#    $BIN_PATH --http-port=8080
#    sleep 1
#   done
# ) &

# (
#   while :
#   do
#    echo "Starting Tor..."
#    tor -f torrc || true
#    # (experiment) kill the server
#    kill $(lsof -t -i:8080 -sTCP:LISTEN) || true
#    sleep 1
#   done
# ) &

# wait

# (experimental)
go run multi-forever.go \
  "[\"$BIN_PATH\", \"--http-port=8080\"]" \
  '["tor", "-f", "torrc"]'
