FROM tomcat:10-jdk17

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file
COPY AjaraBazar.war /usr/local/tomcat/webapps/ROOT.war

# Ensure Tomcat binds to all network interfaces
RUN sed -i 's/Connector port="8080"/Connector port="8080" address="0.0.0.0"/' /usr/local/tomcat/conf/server.xml

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
