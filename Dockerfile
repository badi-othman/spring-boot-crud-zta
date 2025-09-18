# Use a Maven base image that includes Java 17
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven project files
COPY pom.xml .
COPY src ./src

# Build the application and run tests
RUN mvn clean package

# Use a lean base image for the final application to keep it small
FROM eclipse-temurin:17-jre-focal

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the 'build' stage
COPY --from=build /app/target/springboot-thymeleaf-crud-web-app-0.0.1-SNAPSHOT.jar .

# Expose the port your Spring Boot app runs on
EXPOSE 8080

# The command to run the application when the container starts
ENTRYPOINT ["java", "-jar", "springboot-thymeleaf-crud-web-app-0.0.1-SNAPSHOT.jar"]