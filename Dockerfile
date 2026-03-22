FROM tomcat:10.1-jdk17

RUN rm -rf /usr/local/tomcat/webapps/*
COPY AjaraBazar.war /usr/local/tomcat/webapps/ROOT.war
RUN sed -i 's/port="8080"/port="8080" address="0.0.0.0"/' /usr/local/tomcat/conf/server.xml

EXPOSE 8080

CMD ["catalina.sh", "run"]
