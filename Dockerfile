# ====== Build stage ======

FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /app
# Copy source code
COPY . .

# Build application (skip tests for faster CI builds)
RUN mvn clean package -DskipTests


# ====== Runtime stage ======
FROM eclipse-temurin:17-jre
WORKDIR /home/petclinic/

COPY --from=build /app/target/spring-petclinic-*.jar app.jar



EXPOSE 8080

ENV MYSQL_URL=jdbc:mysql://petclinic-mysql:3306/petclinic

ENTRYPOINT ["java", "-jar", "app.jar"]
