# ใช้ Liberica ซึ่งรองรับ Alpine + ARM64 ได้เสถียรมากบน Apple Silicon
FROM bellsoft/liberica-openjdk-alpine:17 AS base

LABEL maintainer="jaturon.pantasuma@gmail.com" \
      description="iText DITO SDK for ARM-based environment"

# กำหนดตัวแปรสภาพแวดล้อม
ENV DITO_HOME=/opt/dito \
    DITO_WORK_DIR=/var/opt/dito \
    JAVA_TOOL_OPTIONS="-Xmx5G -XX:+UseG1GC -Duser.timezone=Asia/Bangkok"

# ติดตั้ง tzdata และสร้าง User เพื่อความปลอดภัย
RUN apk add --no-cache tzdata \
    && addgroup -S dito && adduser -S dito -G dito

# เตรียม Directory และกำหนดสิทธิ์
RUN mkdir -p ${DITO_WORK_DIR}/shared ${DITO_HOME} /var/log/dito \
    && chown -R dito:dito ${DITO_WORK_DIR} ${DITO_HOME} /var/log/dito

WORKDIR ${DITO_HOME}

# คัดลอกไฟล์โปรแกรมและ Config
COPY --chown=dito:dito ./dito-sdk-docker.jar ${DITO_HOME}/dito-sdk-docker.jar
COPY --chown=dito:dito ./config/config-docker.yml ${DITO_WORK_DIR}/shared/config-docker.yml
COPY --chown=dito:dito ./startup.sh ${DITO_HOME}/startup.sh

RUN chmod +x ${DITO_HOME}/startup.sh

USER dito

EXPOSE 8080 8081

# รันผ่าน Startup script เพื่อความยืดหยุ่น
CMD ["./startup.sh"]