FROM adorsys/keycloak-config-cli:latest
USER 0
RUN apt update && apt install -yq curl && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY ./docker-hub/run_tests.sh /app/run_tests.sh
COPY ./docker-hub/realm-export.json /config/realm-export.json
