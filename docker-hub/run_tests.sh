#!/bin/sh
set -x

java $JAVA_OPTS -jar /opt/keycloak-config-cli.jar

CODE=$(curl -s -o /dev/null -w "%{http_code}" http://admin:Pa55w0rd@proxy:8080/)

if [ "$CODE" != "200" ]; then
  echo "wrong success basic auth status response $CODE"
  exit 127
fi

CODE=$(curl -s -o /dev/null -w "%{http_code}" http://admin:admin@proxy:8080/)

if [ "$CODE" != "401" ]; then
  echo "wrong unauthorized basic auth status response $CODE"
  exit 127
fi

