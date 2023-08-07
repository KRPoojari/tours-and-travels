# Stage 1: Build the application using Maven
FROM maven:3.8.1-jdk-11-slim AS builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src/ /app/src/
RUN mvn clean compile package

# Stage 2: Create a lightweight runtime image
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=builder /app/target/*.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
