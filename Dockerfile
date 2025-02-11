FROM openjdk:17-alpine

WORKDIR /app

COPY /tmp/app.jar app.jar

CMD ["java", "-jar", "app.jar"]
