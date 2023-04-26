FROM ubuntu:20.04

ARG FLUTTER_VERSION=3.7.12
ARG COMMANDLINETOOLS_VERSION=9477386
ARG PLATFORMS_VERSION=33
ARG BUILD_TOOLS_VERSION=30.0.3
ARG CMDLINE_TOOLS_VERSION=9.0

ENV TZ=Asia/HoChiMinh \
    DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y openjdk-11-jdk curl xz-utils unzip git \
 && apt-get clean

RUN addgroup --gid 1000 flutter \
    && adduser --disabled-password --uid 1000 --gid 1000 flutter \
    && chown -R 1000:1000 /home/flutter

USER flutter

RUN mkdir /home/flutter/Android

WORKDIR /home/flutter/Android

RUN curl https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz --output flutter.tar.xz

RUN tar -xf flutter.tar.xz && \
    rm flutter.tar.xz

ENV PATH="/home/flutter/Android/flutter/bin:$PATH"

RUN git config --global --add safe.directory /home/flutter/Android/flutter

RUN curl https://dl.google.com/android/repository/commandlinetools-linux-${COMMANDLINETOOLS_VERSION}_latest.zip --output commandlinetools-linux.zip

RUN unzip commandlinetools-linux.zip && \
    rm commandlinetools-linux.zip

RUN mkdir tools && \
    mv cmdline-tools/* tools && \
    mv tools cmdline-tools/

ENV PATH="/home/flutter/Android:/home/flutter/Android/cmdline-tools/tools/bin:/home/flutter/Android/platform-tools:$PATH"

RUN yes | sdkmanager "platform-tools" "platforms;android-${PLATFORMS_VERSION}" "build-tools;${BUILD_TOOLS_VERSION}" "cmdline-tools;${CMDLINE_TOOLS_VERSION}" "emulator"

RUN yes | sdkmanager --licenses

RUN flutter doctor -v

RUN echo "export PATH=/home/flutter/Android/flutter/bin:$PATH" >> ~/.bashrc
