FROM tomcat:10.1-jdk17

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file
COPY AjaraBazar.war /usr/local/tomcat/webapps/ROOT.war

# Ensure Tomcat receives environment variables
ENV CATALINA_OPTS="-Djava.awt.headless=true"

# Create a setenv.sh to pass environment variables to Tomcat
RUN mkdir -p /usr/local/tomcat/bin && \
    echo '#!/bin/bash' > /usr/local/tomcat/bin/setenv.sh && \
    echo 'export MYSQLHOST=${MYSQLHOST}' >> /usr/local/tomcat/bin/setenv.sh && \
    echo 'export MYSQLPORT=${MYSQLPORT}' >> /usr/local/tomcat/bin/setenv.sh && \
    echo 'export MYSQLDATABASE=${MYSQLDATABASE}' >> /usr/local/tomcat/bin/setenv.sh && \
    echo 'export MYSQLUSER=${MYSQLUSER}' >> /usr/local/tomcat/bin/setenv.sh && \
    echo 'export MYSQLPASSWORD=${MYSQLPASSWORD}' >> /usr/local/tomcat/bin/setenv.sh && \
    echo 'export MYSQL_URL=${MYSQL_URL}' >> /usr/local/tomcat/bin/setenv.sh && \
    chmod +x /usr/local/tomcat/bin/setenv.sh

# Configure Tomcat to use setenv.sh
RUN sed -i '1i source /usr/local/tomcat/bin/setenv.sh' /usr/local/tomcat/bin/catalina.sh

# Modify server.xml to ensure Tomcat listens on all interfaces
RUN sed -i 's/port="8080"/port="8080" address="0.0.0.0"/' /usr/local/tomcat/conf/server.xml

# Expose port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
