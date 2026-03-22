FROM tomcat:10-jdk17

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file
COPY AjaraBazar.war /usr/local/tomcat/webapps/ROOT.war

# Copy custom server configuration if needed
COPY Service.xml /usr/local/tomcat/conf/server.xml

# Expose port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
