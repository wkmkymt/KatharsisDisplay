# Kyoto Bar Sample

This is sample application for Kyoto Bar system.


## Set Up

```sh
# Build
$ docker-compose build

# Set Up Database
$ docker-compose run web rails db:create
$ docker-compose run web rails db:migrate
$ docker-compose run web rails db:seed

# Up Server
$ docker-compose up
```