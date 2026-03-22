FROM tomcat:10-jdk17

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file
COPY AjaraBazar.war /usr/local/tomcat/webapps/ROOT.war

# Configure Tomcat to use Railway's PORT
ENV CATALINA_OPTS="-Dport=${PORT}"

# Expose port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
