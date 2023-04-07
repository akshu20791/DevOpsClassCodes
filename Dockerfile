FROM openjdk:11
EXPOSE 8080
ADD /target/addressbook.war addressbook.war
ENTRYPOINT ["java", "-jar", "/addressbook.war"]
