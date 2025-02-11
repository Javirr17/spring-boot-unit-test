FROM openjdk:17-alpine

WORKDIR /app

COPY /tmp/build/app.jar app.jar

CMD ["java", "-jar", "app.jar"]
