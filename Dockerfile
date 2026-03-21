FROM tomcat:10-jdk17
RUN rm -rf /usr/local/tomcat/webapps/*
COPY AjaraBazar.war /usr/local/tomcat/webapps/ROOT.war

# Expose internal port (good practice)
EXPOSE 8080

# Use Railway's dynamic PORT
ENV PORT 8080

# Start Tomcat with dynamic port
CMD ["sh", "-c", "CATALINA_OPTS='-Dport=$PORT' catalina.sh run"]
