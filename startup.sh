#!/bin/ash

# ใช้ exec เพื่อให้รับสัญญาณ SIGTERM ได้ถูกต้อง
# ชี้ไปยัง Path ของ Config file ที่เตรียมไว้ใน Container
exec java $JAVA_TOOL_OPTIONS -jar "${DITO_HOME}/dito-sdk-docker.jar" server \
    "${DITO_WORK_DIR}/shared/config-docker.yml"