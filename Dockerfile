FROM selenium/standalone-chrome:latest
ENV WIREMOCK_VERSION 2.26.3
ENV TZ Europe/Amsterdam

USER root
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

USER seluser

#==============================
# Download Wiremock standalone
#==============================
RUN wget -q -O /home/seluser/wiremock.jar https://repo1.maven.org/maven2/com/github/tomakehurst/wiremock-standalone/${WIREMOCK_VERSION}/wiremock-standalone-${WIREMOCK_VERSION}.jar

#==============================
# Copy runner script
#==============================
COPY start-wiremock-standalone.sh /home/seluser/start-wiremock-standalone.sh

#==============================
# Copy configuration file
#==============================
COPY wiremock.conf /etc/supervisor/conf.d/

#=================================
# Expose admin console on http
# port 8080 and mock on https 9090
#=================================
EXPOSE 8080 9090
