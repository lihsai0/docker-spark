## Usage

### Build Image

``` shell
docker build -t $USER/spark .
```

NOTE: The tsinghua mirror only sync the last version. So building may failed if there is a last version of spark.

The history versions I builed can be found in Aliyun:

Container Registry -> Image Hub -> Search -> lihs/spark

### Create Spark Network

``` shell
docker network create spark-network
```

### Master

``` shell
docker run -d \
  --name spark-master \
  --network=spark-network \
  --hostname=spark-master \
  -p 7077:7077 \
  -p 8080:8080 \
  $USER/spark
```

### Worker

``` shell
docker run -d \
  --name spark-worker1 \
  -e ROLE=worker \
  -e MASTER_URL="spark://spark-master:7077"
  --network=spark-network \
  --hostname=spark-worker1 \
  -p 8081:8080 \
  $USER/spark
```

## Docker Compose

Default config see [docker-compose.yml](./docker-compose.yml)

``` shell
docker-compose up
```

