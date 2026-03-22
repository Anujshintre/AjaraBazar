FROM tomcat:10.1-jdk17

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file
COPY AjaraBazar.war /usr/local/tomcat/webapps/ROOT.war

# Create a simple index page to verify deployment
RUN mkdir -p /usr/local/tomcat/webapps/ROOT && \
    echo '<html><body><h1>AjaraBazar is Live!</h1><p>Deployed successfully on Railway</p></body></html>' > /usr/local/tomcat/webapps/ROOT/index.html

# Configure Tomcat for Railway
RUN sed -i 's/port="8080"/port="8080" address="0.0.0.0"/' /usr/local/tomcat/conf/server.xml

# Expose port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
