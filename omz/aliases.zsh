alias awslocal="AWS_ACCESS_KEY_ID=test AWS_SECRET_ACCESS_KEY=test AWS_DEFAULT_REGION=${DEFAULT_REGION:-$AWS_DEFAULT_REGION} aws --endpoint-url=http://${LOCALSTACK_HOST:-localhost}:4566"

# docker compose aliases
alias dcd="docker-compose down"
alias dcu="docker-compose up"
alias dcud="docker-compose up -d"

# assume alias (https://www.granted.dev/)
alias assume=". assume"

# terraform aliases
alias tfaa="tfa -auto-approve"
alias tfda="tfd -auto-approve"
