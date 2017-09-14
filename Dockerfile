FROM java:8-jdk-alpine
MAINTAINER limaofeng <limaofeng@msn.com>

RUN mkdir /usr/lib/gradle /app

ENV GRADLE_VERSION 2.13
ENV GRADLE_HOME /usr/lib/gradle/gradle-${GRADLE_VERSION}
ENV PATH ${PATH}:${GRADLE_HOME}/bin

WORKDIR /usr/lib/gradle

# 安装 gradle
RUN set -x \
  && apk add --no-cache wget \
  && wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip \
  && unzip gradle-${GRADLE_VERSION}-bin.zip \
  && rm gradle-${GRADLE_VERSION}-bin.zip \
  && apk del wget

# 设置 app 目录
WORKDIR /app

# 添加 bash
RUN apk update && apk add bash libstdc++ && rm -rf /var/cache/apk/*

# 设置时区
RUN apk update && apk add ca-certificates && \
    apk add tzdata && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone
