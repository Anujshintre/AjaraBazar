FROM tomcat:10-jdk17

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR
COPY AjaraBazar.war /usr/local/tomcat/webapps/ROOT.war

# Optional internal exposure
EXPOSE 8080

# Railway provides the port dynamically
ENV PORT 8080

# Start Tomcat with dynamic port
CMD ["sh", "-c", "CATALINA_OPTS='-Dport=$PORT' catalina.sh run"]
