ARG BUILD_FROM
FROM $BUILD_FROM

# Execute during the build of the image
ARG TEMPIO_VERSION BUILD_ARCH
RUN \
    curl -sSLf -o /usr/bin/tempio \
    "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}"

RUN apk update
RUN apk --no-cache add socat
RUN pip install --no-cache-dir pyserial paho-mqtt PyYAML


RUN mkdir -p /opt/hacomfoairmqtt
COPY src/ca350.py /opt/hacomfoairmqtt
COPY src/config.ini.docker /opt/hacomfoairmqtt/config.ini.docker

COPY rootfs /