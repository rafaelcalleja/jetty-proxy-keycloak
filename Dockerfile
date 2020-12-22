FROM maven:3.6-jdk-8 AS build
WORKDIR /build

COPY src /build/src
COPY pom.xml /build/pom.xml

RUN mvn clean install

FROM jetty:9.4.35-jdk15-slim

EXPOSE 8080

COPY --from=build /build/target/*.war /var/lib/jetty/webapps/ROOT.war
COPY src/resources/keycloak-jetty94-adapter-dist-12.0.1.tar.gz ${TMPDIR}/keycloak.tar.gz

RUN cd ${JETTY_BASE} && \
    tar xvfz ${TMPDIR}/keycloak.tar.gz && \
    java -jar $JETTY_HOME/start.jar --add-to-startd=keycloak

CMD java -jar ${JETTY_HOME}/start.jar -DHOST_HEADER=${HOST_HEADER} -DPROXY_TO=${PROXY_TO} -DREALM_NAME=${REALM_NAME} -DAUTH_SERVER=${AUTH_SERVER} -DCLIENT_ID=${CLIENT_ID} -DCLIENT_SECRET=${CLIENT_SECRET}