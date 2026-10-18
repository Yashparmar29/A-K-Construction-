# Multi-stage Docker build for A K Construction (Spring Boot)
FROM maven:3.9.6-eclipse-temurin-8 AS build

WORKDIR /app

# Cache Maven dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B || true

# Copy source code and package application
COPY src ./src
COPY WebContent ./WebContent
RUN mvn clean package -DskipTests

# Runtime Stage (official Temurin 8 JRE)
FROM eclipse-temurin:8-jre

WORKDIR /app

# Copy the built war
COPY --from=build /app/target/app.war app.war

ENV PORT=8080
EXPOSE 8080

CMD ["sh", "-c", "java -Dserver.port=${PORT:-8080} -Djava.security.egd=file:/dev/./urandom -jar app.war"]
