FROM maven:3.8.4-openjdk-17 AS build
VOLUME /tmp
WORKDIR /app

# Copy the pom.xml file and the source code
COPY pom.xml .
COPY src ./src

# Package the application (skip tests if necessary)
RUN mvn package -DskipTests
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /dimanch


# Copy the jar file from the build stage
COPY --from=build /dimanch/target/demo.jar /dimanch/demo.jar

# Specify the command to run the application
CMD ["java", "-jar", "demo.jar"]

# Expose the port the application runs on
EXPOSE 8080








