FROM nginx:alpine

RUN apk -U add openjdk8 \
    && rm -rf /var/cache/apk/*;
RUN apk add ttf-dejavu

ENV JAVA_OPTS=""
ARG JAR_FILE
ADD ${JAR_FILE} app.jar

VOLUME /tmp
RUN rm -rf /usr/share/nginx/html/*
COPY nginx.conf /etc/nginx/nginx.conf
COPY dist/billingApp /usr/share/nginx/html
COPY appshell.sh appshell.sh

EXPOSE 80 8080
ENTRYPOINT ["sh", "/appshell.sh"]

