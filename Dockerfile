FROM maven:3.8.3-openjdk-17 AS build

# Set working directory
WORKDIR /app

# Copy the Maven project files
COPY pom.xml ./
COPY src ./src/

# Build the Maven project
RUN mvn clean package -Pprod -DskipTests

FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy the JAR file from the build stage to the new image
COPY --from=build /app/target/DogsManagementSystem-0.0.1-SNAPSHOT.jar DogsManagementSystem.jar

# Set the command to run the JAR file
CMD ["java", "-jar", "DogsManagementSystem.jar"]
