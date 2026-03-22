FROM tomcat:10.1-jdk17

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file
COPY AjaraBazar.war /usr/local/tomcat/webapps/ROOT.war

# Download MySQL connector directly
ADD https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/9.2.0/mysql-connector-j-9.2.0.jar /usr/local/tomcat/lib/mysql-connector.jar

# Create a setenv.sh file to set environment variables for Tomcat
RUN echo '#!/bin/bash' > /usr/local/tomcat/bin/setenv.sh && \
    echo 'export MYSQLHOST="mysql.railway.internal"' >> /usr/local/tomcat/bin/setenv.sh && \
    echo 'export MYSQLPORT="3306"' >> /usr/local/tomcat/bin/setenv.sh && \
    echo 'export MYSQLDATABASE="railway"' >> /usr/local/tomcat/bin/setenv.sh && \
    echo 'export MYSQLUSER="root"' >> /usr/local/tomcat/bin/setenv.sh && \
    echo 'export MYSQLPASSWORD="pTmEMwqyojydgyspyqIWKkvEgBjxlRhA"' >> /usr/local/tomcat/bin/setenv.sh && \
    echo 'export MYSQL_URL="jdbc:mysql://mysql.railway.internal:3306/railway?useSSL=false&allowPublicKeyRetrieval=true"' >> /usr/local/tomcat/bin/setenv.sh && \
    chmod +x /usr/local/tomcat/bin/setenv.sh

# Configure Tomcat to use setenv.sh
RUN echo '#!/bin/bash' > /usr/local/tomcat/bin/startup.sh && \
    echo 'source /usr/local/tomcat/bin/setenv.sh' >> /usr/local/tomcat/bin/startup.sh && \
    echo 'echo "=== MySQL Environment Variables ==="' >> /usr/local/tomcat/bin/startup.sh && \
    echo 'echo "MYSQLHOST: $MYSQLHOST"' >> /usr/local/tomcat/bin/startup.sh && \
    echo 'echo "MYSQLPORT: $MYSQLPORT"' >> /usr/local/tomcat/bin/startup.sh && \
    echo 'echo "MYSQLDATABASE: $MYSQLDATABASE"' >> /usr/local/tomcat/bin/startup.sh && \
    echo 'echo "MYSQLUSER: $MYSQLUSER"' >> /usr/local/tomcat/bin/startup.sh && \
    echo 'echo "================================"' >> /usr/local/tomcat/bin/startup.sh && \
    echo 'exec catalina.sh run' >> /usr/local/tomcat/bin/startup.sh && \
    chmod +x /usr/local/tomcat/bin/startup.sh

# Ensure Tomcat listens on all interfaces
RUN sed -i 's/port="8080"/port="8080" address="0.0.0.0"/' /usr/local/tomcat/conf/server.xml

EXPOSE 8080

CMD ["/usr/local/tomcat/bin/startup.sh"]
