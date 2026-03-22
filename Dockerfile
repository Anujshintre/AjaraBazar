FROM tomcat:10.1-jdk17

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file
COPY AjaraBazar.war /usr/local/tomcat/webapps/ROOT.war

# Download MySQL connector directly to Tomcat lib
ADD https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/9.2.0/mysql-connector-j-9.2.0.jar /usr/local/tomcat/lib/mysql-connector.jar

# Create startup script
RUN echo '#!/bin/bash' > /usr/local/tomcat/bin/start.sh && \
    echo '# Export Railway environment variables' >> /usr/local/tomcat/bin/start.sh && \
    echo 'export MYSQLHOST="'"${MYSQLHOST}"'"' >> /usr/local/tomcat/bin/start.sh && \
    echo 'export MYSQLPORT="'"${MYSQLPORT}"'"' >> /usr/local/tomcat/bin/start.sh && \
    echo 'export MYSQLDATABASE="'"${MYSQLDATABASE}"'"' >> /usr/local/tomcat/bin/start.sh && \
    echo 'export MYSQLUSER="'"${MYSQLUSER}"'"' >> /usr/local/tomcat/bin/start.sh && \
    echo 'export MYSQLPASSWORD="'"${MYSQLPASSWORD}"'"' >> /usr/local/tomcat/bin/start.sh && \
    echo 'export MYSQL_URL="'"${MYSQL_URL}"'"' >> /usr/local/tomcat/bin/start.sh && \
    echo 'echo "=== Environment Variables ==="' >> /usr/local/tomcat/bin/start.sh && \
    echo 'echo "MYSQLHOST: $MYSQLHOST"' >> /usr/local/tomcat/bin/start.sh && \
    echo 'echo "MYSQLPORT: $MYSQLPORT"' >> /usr/local/tomcat/bin/start.sh && \
    echo 'echo "MYSQLDATABASE: $MYSQLDATABASE"' >> /usr/local/tomcat/bin/start.sh && \
    echo 'echo "MYSQLUSER: $MYSQLUSER"' >> /usr/local/tomcat/bin/start.sh && \
    echo 'echo "=========================="' >> /usr/local/tomcat/bin/start.sh && \
    echo 'exec catalina.sh run' >> /usr/local/tomcat/bin/start.sh && \
    chmod +x /usr/local/tomcat/bin/start.sh

# Ensure Tomcat listens on all interfaces
RUN sed -i 's/port="8080"/port="8080" address="0.0.0.0"/' /usr/local/tomcat/conf/server.xml

EXPOSE 8080

CMD ["/usr/local/tomcat/bin/start.sh"]
