FROM tomcat:10-jdk17

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR
COPY AjaraBazar.war /usr/local/tomcat/webapps/ROOT.war

# Replace port dynamically
RUN sed -i 's/port="8080"/port="${PORT}"/' /usr/local/tomcat/conf/server.xml

EXPOSE 8080
