From maven:3.8.3-openjdk-17 as build
RUN mvn install -DskipTests=true


run mvn clean package 
from openjdk:17-jdk-slim
COPY --from=build /app/target/dimanch.jar /app/dimanch.jar
COPY --from=build /build/libs/dimanch.jar app/dimanch.jar

EXPOSE 8080
RUN wget https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz && \
    tar -xzvf apache-maven-$MAVEN_VERSION-bin.tar.gz -C /opt && \
    ln -s /opt/apache-maven-$MAVEN_VERSION /opt/maven && \
    ln -s /opt/maven/bin/mvn /usr/bin/mvn && \
    rm apache-maven-$MAVEN_VERSION-bin.tar.gz

# Set environment variables for Maven
ENV MAVEN_HOME=/opt/maven
ENV PATH=$MAVEN_HOME/bin:$PATH

# Set the working directory
WORKDIR /app
ENTRYPOINT ["java", "-jar", "target/dimanch.jar"]



#ENTRYPOINT ["java","-jar","voyelle-software-1.jar"]
#ENTRYPOINT ["java","-jar","app.jar"]
#ENTRYPOINT ["java", "-Dspring.profiles.active=prod", "-jar", "/app/voyelle-software-1.jar"]


# Use an official Maven image to build the application
#From maven:3.2.5-openjdk-17 as build


#FROM ubuntu:latest AS build

#RUN apt-get update
##RUN apt-get install openjdk-17-jdk -y
#COPY . .

#RUN apt-get update && \
    #apt-get install dos2unix && \
   # apt-get clean
#RUN dos2unix gradlew
#RUN chmod +x gradlew
#RUN ./gradlew lib:build

#FROM openjdk:22-jdk-slim

#EXPOSE 8080

#COPY --from=build /build/libs/voyelle-software-1.jar app.jar

#ENTRYPOINT ["java", "-jar", "app.jar"]