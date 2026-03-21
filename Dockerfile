FROM tomcat:10-jdk17
RUN rm -rf /usr/local/tomcat/webapps/*
COPY AjaraBazar.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
