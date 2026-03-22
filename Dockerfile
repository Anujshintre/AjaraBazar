FROM tomcat:10-jdk17

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file
COPY AjaraBazar.war /usr/local/tomcat/webapps/ROOT.war

# Create a simple test page to verify Tomcat is working
RUN echo '<html><body><h1>AjaraBazar is Running!</h1><p>Tomcat is working correctly.</p></body></html>' > /usr/local/tomcat/webapps/ROOT/index.html

# Modify server.xml to ensure Tomcat listens on all interfaces
RUN sed -i 's/port="8080"/port="8080" address="0.0.0.0"/' /usr/local/tomcat/conf/server.xml

# Expose port
EXPOSE 8080

# Start Tomcat with debug output
CMD ["catalina.sh", "run"]
