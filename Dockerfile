FROM openjdk:8-alpine

RUN sed -i '/<\/tomcat-users>/ i\<user username="admin" password="agunu" roles="admin-gui,manager-gui"/>' /opt/app/tomcat/conf/tomcat-users.xml

# Required for starting application up.
RUN apk update && apk add /bin/sh

RUN mkdir -p /opt/app
ENV PROJECT_HOME /opt/app

COPY target/spring-boot-mongo-1.0.jar $PROJECT_HOME/spring-boot-mongo.jar

WORKDIR $PROJECT_HOME

CMD ["java", "-Dspring.data.mongodb.uri=mongodb://mongo:27017/spring-mongo","-Djava.security.egd=file:/dev/./urandom","-jar","./spring-boot-mongo.jar"]
