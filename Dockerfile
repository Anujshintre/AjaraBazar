FROM tomcat:10.1-jdk17

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file
COPY AjaraBazar.war /usr/local/tomcat/webapps/ROOT.war

# Create a simple test page
RUN mkdir -p /usr/local/tomcat/webapps/ROOT && \
    echo '<html><body><h1>AjaraBazar is Running on Tomcat 10.1!</h1><p>Deployment successful.</p></body></html>' > /usr/local/tomcat/webapps/ROOT/index.html

# Ensure Tomcat listens on all interfaces
RUN sed -i 's/Connector port="8080"/Connector port="8080" address="0.0.0.0"/' /usr/local/tomcat/conf/server.xml

# Expose port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
