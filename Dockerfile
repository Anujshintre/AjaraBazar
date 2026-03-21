FROM tomcat:10-jdk17

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR to ROOT.war
COPY AjaraBazar.war /usr/local/tomcat/webapps/ROOT.war

# Expose internal port (optional)
EXPOSE 8080

# Use Railway's PORT environment variable
ENV PORT 8080

# Start Tomcat binding to the dynamic port
CMD ["sh", "-c", "CATALINA_OPTS='-Dport=$PORT' catalina.sh run"]
