FROM selenium/standalone-chrome:latest
ENV WIREMOCK_VERSION 2.26.3
ENV TZ Europe/Amsterdam

USER root
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#==============================
# Download Wiremock standalone
#==============================
RUN wget -q -O /opt/bin/wiremock.jar https://repo1.maven.org/maven2/com/github/tomakehurst/wiremock-standalone/${WIREMOCK_VERSION}/wiremock-standalone-${WIREMOCK_VERSION}.jar

#==============================
# Copy runner script
#==============================
COPY start-wiremock-standalone.sh /opt/bin/start-wiremock-standalone.sh
RUN chmod 777 /opt/bin/start-wiremock-standalone.sh

#==============================
# Copy configuration file
#==============================
COPY wiremock.conf /etc/supervisor/conf.d/

USER seluser
#=================================
# Expose admin console on http
# port 8080 and mock on https 9090
#=================================
EXPOSE 8080 9090
