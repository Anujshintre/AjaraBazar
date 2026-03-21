# Use Tomcat with JDK 17
FROM tomcat:10-jdk17

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR to ROOT.war
COPY AjaraBazar.war /usr/local/tomcat/webapps/ROOT.war

# Expose internal container port (not strictly needed, but good practice)
EXPOSE 8080

# Use Railway's dynamic PORT environment variable
ENV PORT 8080

# Start Tomcat with the PORT Railway provides
CMD ["sh", "-c", "CATALINA_OPTS='-Dport=$PORT' catalina.sh run"]
