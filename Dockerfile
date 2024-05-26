# Use an official Maven image to build the project
FROM maven:3.8.4-openjdk-17 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the pom.xml file and the source code
COPY pom.xml .
COPY src ./src

# Package the application (skip tests if necessary)
RUN mvn package -DskipTests

# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the jar file from the build stage
COPY --from=build /app/target/your-app-name.jar /app/your-app-name.jar

# Specify the command to run the application
CMD ["java", "-jar", "dimanch.jar"]

# Expose the port the application runs on
EXPOSE 8080