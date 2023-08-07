# Stage 1: Pull the app from GitHub and build using Maven
FROM maven:3.8.1-jdk-11-slim AS builder

WORKDIR /app

# Install Git to clone the repository
RUN apt-get update && apt-get install -y git

# Clone the repository from GitHub
RUN git clone https://github.com/KRPoojari/tours-and-travels.git .

# Copy the pom.xml to the container
COPY pom.xml .

# Download the project dependencies
RUN mvn dependency:go-offline

# Build the application using Maven
RUN mvn clean compile package

# Stage 2: Create a lightweight runtime image
FROM openjdk:11-jre-slim

WORKDIR /app

# Copy the built jar file from the previous stage
COPY --from=builder /app/target/*.jar /app/app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
