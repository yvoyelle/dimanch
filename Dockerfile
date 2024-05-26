FROM maven:17-jdk-alpine
VOLUME /tmp
COPY target/*.jar app.jar
ENTRYPOINT ["java","-jar","/demo.jar"]
EXPOSE 8080