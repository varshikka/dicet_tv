# Use official Tomcat with JDK17
FROM tomcat:9.0-jdk17-temurin

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR file from target folder into Tomcat
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose default Tomcat port
EXPOSE 8080

# Run Tomcat
CMD ["catalina.sh", "run"]

