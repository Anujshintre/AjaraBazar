FROM tomcat:10-jdk17

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR as ROOT.war
COPY AjaraBazar.war /usr/local/tomcat/webapps/ROOT.war

# Expose internal port (optional)
EXPOSE 8080

# Set dynamic port (Railway provides PORT env variable)
ENV PORT 8080

# Start Tomcat with dynamic port
# Use single string form so shell expands $PORT
CMD sh -c "sed -i 's/port=\"8080\"/port=\"${PORT}\"/' /usr/local/tomcat/conf/server.xml && catalina.sh run"
