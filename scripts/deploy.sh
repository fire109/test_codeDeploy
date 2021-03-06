#!/bin/bash
BUILD_PATH=$(ls /home/ec2-user/build/target/*.jar)
JAR_NAME=$(basename $BUILD_PATH)
echo "> build 파일명: $JAR_NAME"

DEPLOY_PATH=/home/ec2-user/deploy/
cp $BUILD_PATH $DEPLOY_PATH

APPLICATION_JAR_NAME=demo-0.0.1-SNAPSHOT.jar
APPLICATION_JAR=$DEPLOY_PATH$APPLICATION_JAR_NAME

echo "> 현재 실행중인 애플리케이션 pid 확인"
CURRENT_PID=$(pgrep -f $APPLICATION_JAR_NAME)

if [ -z $CURRENT_PID ]
then
  echo "> 현재 구동중인 애플리케이션이 없으므로 종료하지 않습니다."
else
  echo "> kill -15 $CURRENT_PID"
  kill -15 $CURRENT_PID
  sleep 5
fi

echo "> $APPLICATION_JAR 배포"
nohup java -jar $APPLICATION_JAR > /dev/null 2> /dev/null < /dev/null &