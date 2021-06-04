# README

## Prerequisites

To set up your development environment, you'll need to following:

- [Docker](https://www.docker.com/)
- A Ruby version manager ([RVM](https://rvm.io/) or [Rbenv](https://github.com/sstephenson/rbenv) preferred)
- The appropriate version of Ruby, along with the Bundler gem

## Setting up

You'll need the PostgreSQL client library, so if you don't already have it installed then do so now:
```sh
brew install postgresql
```

Install the necessary gems:
```sh
bundle install
```

## Running the build

Start up Docker Compose:
```sh
docker-compose up -d
```

To run the build:
```sh
bundle exec rake
```

## Production setup

You'll need the connection string to your PostgreSQL set in the ENV variable
```sh
ENV['DATABASE_URL']
```
