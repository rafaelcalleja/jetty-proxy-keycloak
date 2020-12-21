FROM maven:3.6-jdk-8 AS build
WORKDIR /build
COPY . /build
RUN mvn clean install

FROM jetty:9.4.35-jdk15

EXPOSE 8080

COPY --from=build /build/target/*.war /var/lib/jetty/webapps/ROOT.war
COPY src/resources/keycloak-jetty94-adapter-dist-12.0.1.tar.gz ${TMPDIR}/keycloak.tar.gz

RUN cd ${JETTY_BASE} && \
    tar xvfz ${TMPDIR}/keycloak.tar.gz && \
    java -jar $JETTY_HOME/start.jar --add-to-startd=keycloak
