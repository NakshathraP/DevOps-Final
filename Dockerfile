FROM openjdk:21-jre
COPY target/myapp-1.0-SNAPSHOT.jar /app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]