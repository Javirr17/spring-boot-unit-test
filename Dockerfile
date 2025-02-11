FROM openjdk:17-alpine

WORKDIR /app

COPY app.jar .

CMD ["java", "-jar", "app.jar"]
