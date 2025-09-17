# Start with a base image that has Java installed.
# We use a slimmed-down version for a smaller image size.
FROM eclipse-temurin:17-jdk-focal

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven build file (pom.xml) and download all dependencies.
# This step is cached by Docker, speeding up subsequent builds.
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the entire project source code into the container.
COPY . .

# Package the application into a single executable JAR file.
RUN mvn package -DskipTests

# Expose the port your Spring Boot app runs on.
EXPOSE 8080

# The command to run the application when the container starts.
ENTRYPOINT ["java", "-jar", "target/springboot-thymeleaf-crud-web-app-0.0.1-SNAPSHOT.jar"]