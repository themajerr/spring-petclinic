FROM eclipse-temurin:17.0.6_10-jre-alpine

RUN mkdir /opt/app
COPY --chmod=777 ./build/libs/*.jar /opt/app/app.jar

ENTRYPOINT ["java", "-jar", "/opt/app/app.jar"]
