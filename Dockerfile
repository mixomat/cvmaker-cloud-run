FROM ghcr.io/graalvm/graalvm-ce:java11-21.2.0 AS graalvm
RUN gu install native-image
WORKDIR /home/app
COPY layers/libs /home/app/libs
COPY layers/resources /home/app/resources
COPY layers/application.jar /home/app/application.jar
RUN native-image -H:Class=com.example.ApplicationKt -H:Name=application -H:ConfigurationFileDirectories=/Users/marc/projects/micronaut/demo/build/generated/resources/graalvm --no-fallback -cp /home/app/libs/*.jar:/home/app/resources:/home/app/application.jar
FROM frolvlad/alpine-glibc:alpine-3.12
RUN apk update && apk add libstdc++
COPY --from=graalvm /home/app/application /app/application
ENTRYPOINT ["/app/application"]
