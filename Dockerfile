# Use an official Maven image as a build stage
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

# Use a lightweight OpenJDK JRE image as a runtime stage
FROM openjdk:17-slim
WORKDIR /app
COPY --from=build /app/target/*.jar ./app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
