#!/bin/sh
#
# chkconfig: 2345 20 80
# description: GeoWave MiniAccumulo Cluster

SERVICE_NAME=geowave
PATH_TO_JAR=/home/vagrant/geowave/examples/target/geowave-singlejar.jar
CLASS_TO_RUN=mil.nga.giat.geowave.datastore.accumulo.app.GeoWaveDemoApp
PID_PATH_NAME=/tmp/geowave-pid
case $1 in
    start)
        echo "Starting $SERVICE_NAME ..."
        if [ ! -f $PID_PATH_NAME ]; then
            nohup java -Dinteractive=false -cp $PATH_TO_JAR $CLASS_TO_RUN /tmp 2>> /dev/null >> /dev/null &
                        echo $! > $PID_PATH_NAME
            echo "$SERVICE_NAME started ..."
        else
            echo "$SERVICE_NAME is already running ..."
        fi
    ;;
    stop)
        if [ -f $PID_PATH_NAME ]; then
            PID=$(cat $PID_PATH_NAME);
            echo "$SERVICE_NAME stopping ..."
            kill $PID;
            echo "$SERVICE_NAME stopped ..."
            rm $PID_PATH_NAME
        else
            echo "$SERVICE_NAME is not running ..."
        fi
    ;;
    restart)
        if [ -f $PID_PATH_NAME ]; then
            PID=$(cat $PID_PATH_NAME);
            echo "$SERVICE_NAME stopping ...";
            kill $PID;
            echo "$SERVICE_NAME stopped ...";
            rm $PID_PATH_NAME
            echo "$SERVICE_NAME starting ..."
            nohup java -Dinteractive=false -cp $PATH_TO_JAR $CLASS_TO_RUN /tmp 2>> /dev/null >> /dev/null &
                        echo $! > $PID_PATH_NAME
            echo "$SERVICE_NAME started ..."
        else
            echo "$SERVICE_NAME is not running ..."
        fi
    ;;
esac 
