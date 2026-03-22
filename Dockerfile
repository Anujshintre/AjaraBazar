FROM tomcat:10-jdk17

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file
COPY AjaraBazar.war /usr/local/tomcat/webapps/ROOT.war

# Debug: List contents of WAR file
RUN echo "=== WAR file contents (first 20 entries) ===" && \
    jar tf /usr/local/tomcat/webapps/ROOT.war | head -20

# Debug: Check if there's an index.html or index.jsp
RUN echo "=== Checking for index files ===" && \
    jar tf /usr/local/tomcat/webapps/ROOT.war | grep -E "(index\.|health\.)" || echo "No index files found"

# Expose port 8080
EXPOSE 8080

# Start Tomcat with verbose logging
CMD ["catalina.sh", "run"]
