#!/bin/sh

echo $HOSTNAME

if [ $ROLE == "master" ]
	then
		$SPARK_HOME/bin/spark-class org.apache.spark.deploy.master.Master \
		--ip `hostname` --port 7077 --webui-port 8080
	else
		$SPARK_HOME/bin/spark-class org.apache.spark.deploy.worker.Worker \
		--webui-port 8080 $MASTER_URL
fi

