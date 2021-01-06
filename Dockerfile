FROM openjdk:8-alpine

ARG SPARK_DOWNLOAD_URL="http://mirrors.tuna.tsinghua.edu.cn/apache/spark/spark-2.4.7/spark-2.4.7-bin-hadoop2.7.tgz"

ENV SPARK_HOME="/spark" \
ROLE="master" \
MASTER_URL="spark://spark-master:7077"

RUN \
 echo "**** install build packages ****" && \
 sed -i "s/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g" /etc/apk/repositories && \
 apk add --no-cache \
	bash \
 	curl \
	tar && \
 echo "**** install spark ****" && \
 curl -o \
 /tmp/spark.tgz -L \
	$SPARK_DOWNLOAD_URL && \
 mkdir $SPARK_HOME && \
 tar xf \
	/tmp/spark.tgz -C \
	$SPARK_HOME --strip-components=1 && \
 rm -f /tmp/spark.tgz

COPY root/ /

EXPOSE 7077 8080

ENTRYPOINT ["/bin/sh", "/run.sh"]

