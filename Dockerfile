# Multi-stage Docker build for A K Construction (Spring Boot)
FROM maven:3.9.6-eclipse-temurin-8 AS build

WORKDIR /app

# Cache Maven dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source code and package application
COPY src ./src
COPY WebContent ./WebContent
RUN mvn clean package -DskipTests

# Runtime Stage
FROM eclipse-temurin:8-jre-alpine

WORKDIR /app

# Copy the built jar
COPY --from=build /app/target/ak-construction-*.jar app.jar

ENV PORT=8080
EXPOSE 8080

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "app.jar"]
