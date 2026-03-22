#!/bin/bash
# Download and run Tomcat with your WAR
wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.52/bin/apache-tomcat-10.1.52.tar.gz
tar -xzf apache-tomcat-10.1.52.tar.gz
cp AjaraBazar.war apache-tomcat-10.1.52/webapps/ROOT.war
cd apache-tomcat-10.1.52/bin
./catalina.sh run
