export PATH="$PATH:$HOME/.rvm/bin"
export PATH="/$HOME/.rd/bin:$PATH"
export SDKMAN_DIR="$HOME/.sdkman"
export NVM_DIR="$HOME/.nvm"
export DEFAULT_REGION=us-east-1

export PATH="${HOME}/.local/bin:${PATH}"
export PATH="${HOME}/.cargo/bin:${PATH}"

if [[ -d "/opt/netskope/certs" ]]; then
  # Netskope SSL Decryption Cert
  export REQUESTS_CA_BUNDLE=/opt/netskope/certs/nscacert_combined.pem
  export CURL_CA_BUNDLE=/opt/netskope/certs/nscacert_combined.pem
  export SSL_CERT_DIR=/opt/netskope/certs/nscacert_combined.pem
  export PIP_CERT=/opt/netskope/certs/nscacert_combined.pem
  export NODE_EXTRA_CA_CERTS=/opt/netskope/certs/nscacert_combined.pem
  export GIT_SSL_CAPATH=/opt/netskope/certs/nscacert_combined.pem
  export SSL_CERT_FILE=/opt/netskope/certs/nscacert_combined.pem
  export HTTPLIB2_CA_CERTS=/opt/netskope/certs/nscacert_combined.pem
fi

export JAVA_HOME="${SDKMAN_DIR:-$HOME/.sdkman}/candidates/java/current"
export PATH="${JAVA_HOME}/bin:${PATH}"
