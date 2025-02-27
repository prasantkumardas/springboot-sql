# Stage 1: Build stage 284
FROM maven:3.8.5-openjdk-17-slim AS build
WORKDIR /app
ENV DISPLAY=:0
COPY . .
RUN ./mvnw package -DskipTests

# Stage 2: Runtime stage
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]



# Stage 1: Build stage 
FROM maven:3.8.5-openjdk-17-slim AS build
WORKDIR /app
COPY . .
RUN ./mvnw package -DskipTests

# Stage 2: Runtime stage
FROM openjdk:17-jdk-slim AS runtime
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
CMD ["java", "-jar", "app.jar"]

