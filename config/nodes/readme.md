# Bitcoin

```
echo "Start BTC node..." && \
BITCOIN_CORE_VERSION="0.19.1" \
BITCOIN_API_USERNAME="логин" \
BITCOIN_API_PASSWORD="пароль" \
docker-compose -f ./bitcoin/docker-compose.yml up -d --build
```

# Ethereum 

```
docker-compose -f ./ethereum/docker-compose.yml up -d --build
```