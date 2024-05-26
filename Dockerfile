FROM maven:17-jdk-alpine
VOLUME /tmp
COPY target/*.jar app.jar
ENTRYPOINT ["java","-jar","/dimanch.jar"]
EXPOSE 8080