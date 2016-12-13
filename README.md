[![](https://badge.imagelayers.io/seayou/elasticmq:latest.svg)](https://imagelayers.io/?images=seayou/elasticmq:latest 'Get your own badge on imagelayers.io')

## ElasticMQ Docker Image

Provides [ElasticMQ](https://github.com/adamw/elasticmq).

 * The image is using Alpine linux (gliderlabs/alpine), making its size around 125 MB.
   It uses [Tini](https://github.com/krallin/tini), a minimalistic init system to handle signaling properly.

##### Supported tags and respective `Dockerfile` links
 * [`latest`(Dockerfile)](https://github.com/cu12/docker-elasticmq/blob/master/Dockerfile)

##### cu12/elasticmq:latest

Installs the latest (0.12.0) version of ElasticMQ and exposes port 9324.

Running should be as simple as:

    docker run -p 9324:9324 -d seayou/elasticmq

If you wish to customise the settings, mount your config at `/elasticmq/custom.conf`.

Use AWSCLI to manage SQS:

```sh
docker exec <container_id> bash -c "AWS_ACCESS_KEY_ID=fake AWS_SECRET_ACCESS_KEY=fake AWS_DEFAULT_REGION=fake aws --endpoint-url http://localhost:9324 sqs create-queue --queue-name <queue_name>"
```
