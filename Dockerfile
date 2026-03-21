FROM tomcat:10-jdk17

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR as ROOT.war
COPY AjaraBazar.war /usr/local/tomcat/webapps/ROOT.war

# Expose port internally (optional)
EXPOSE 8080

# Use Railway dynamic port
ENV PORT 8080

# Start Tomcat with dynamic port
CMD ["sh", "-c", "sed -i 's/port=\"8080\"/port=\"$PORT\"/' /usr/local/tomcat/conf/server.xml && catalina.sh run"]
