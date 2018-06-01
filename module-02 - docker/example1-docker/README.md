# Commands

## Docker

`docker run hello-world`

`docker run -it node:8-alpine bash`

`docker ps`

### Testing node on container

`node -e '1+1' -p`

### Dockerizing our apps

`git clone https://github.com/ErickWendel/nodejs-with-mongodb-api-example.git`

`cd nodejs-with-mongodb-api-example`

`npm i`

`npm run build`

`npm start #causes exception because mongoDB is not installed`

`touch Dockerfile .dockerignore`

`docker run -d --name mongodb mongo:3.5`

`docker build -t api-example .`

`docker run -p 3000:3000 --link mongodb:mongo -e MONGO_URL=mongodb api-example`

#### Linux Systems

Obs: if you are on linux sytem, npm install script, fails because you need `sudo` permissions. Try to run `sudo npm i -g typescript` and remove `"preinstall": "npm i -g typescript"` line from [package.json](nodejs-with-mongodb-api-example/package.json#L7), after that, try `npm i` again.
