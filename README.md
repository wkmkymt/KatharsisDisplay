# Katharsis Display ![](https://github.com/wkmkymt/test/workflows/Build/badge.svg)

Katharsis Display is System for Kyoto Bar.

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