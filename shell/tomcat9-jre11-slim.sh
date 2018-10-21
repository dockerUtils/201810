#!/bin/bash
docker run --rm --name tomcat9_temp_container -d tomcat:9-jre11-slim

rm -rf $PWD/webapps
docker cp tomcat9_temp_container:/usr/local/tomcat/webapps $PWD
docker stop tomcat9_temp_container

CURRENT_DIR_NAME=`pwd | awk -F "/" '{print $NF}'`

docker run -p 8080:8080 -d --name $CURRENT_DIR_NAME \
    -v $PWD/webapps:/usr/local/tomcat/webapps tomcat:9-jre11-slim
