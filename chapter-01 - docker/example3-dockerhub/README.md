# Commands

## Docker

`docker login`

`docker images`

`REGISTRY=erickwendel #your username`

`docker tag nodejswithmongodbapiexample_api-heroes $REGISTRY/api-heroes`

`docker images`

`docker push erickwendel/api-heroes`

`docker rmi erickwendel/api-heroes`

`#update your docker-compose with erickwende/api-heroes image name`

`cd nodejs-with-mongodb-api-example`

`docker-compose up`

`# alter some text in your application`

`docker build -t erickwendel/api-heroes .`

`docker push erickwendel/api-heroes`

`docker-compose down`

`docker rmi $(docker images | grep api-) | awk '{print $3}')`

`docker pull erickwendel/api-heroes`

`docker-compose up`