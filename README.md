# Event Planner
> A goal without a plan is just a wish.  
> -- Antoine de Saint-Exupéry

Web application built on Ruby on Rails that will help you manage events with pleasure. This application will help you efficiently organize your time and will always tell you about a business meeting, going to the dentist or a friend's birthday.  You no longer need to keep a lot of events in your head, because this is the work of the "Event Planner".

## Table of Contents
* [Features](#features)
* [Necessary Tools](#necessary-tools)
* [Before Running](#before-running)
* [Running The Project](#running-the-project)
  - [Locally](#locally)
  - [Docker-way](#docker-way)
* [Running Tests](#running-tests)
  - [Locally](#locally-1)
  - [Docker-way](#docker-way-1)
* [Contacts](#contacts)

## Features
* Easy registration by email and password
* Сreating, viewing, editing and deleting events
* Custom and predefined categories
* Event search by name and category
* Viewing the weather conditions on the event page
* Receiving email notifications of upcoming events

## Necessary Tools
Before using the application, make sure you have installed:
* [Ruby 3.2.2](https://gist.github.com/pboksz/4649025)
* [Bundler](https://rubygems.org/gems/bundler/versions/2.4.18)
* [PostgreSQL](https://www.postgresql.org/download/)
* [Redis](https://redis.io/docs/install/install-redis/)
* [Docker](https://docs.docker.com/engine/install/)

(You only need [Docker](https://docs.docker.com/engine/install/) if you don't plan to run the application locally)

## Before Running

#### 1. Check out the repository
You can clone an existing repository to your local computer, or to a codespace:

```sh
$ git clone git@github.com:iorhael/trainee-planner.git
```
Then change directory to `trainee-planner`:

```sh
$ cd trainee-planner
```
#### 2. Customize `.env` file
To work with databases you should follow a few simple steps:  
1. First of all, copy `.env.sample` file:
```sh
$ cp .env.sample .env
```
2. And then in created `.env` file change the values of the variables. Don't worry about security: this file is already in `.gitignore`.

## Running The Project
You can run the project in two ways: [Locally](#locally) or in [Docker-way](#docker-way).

### Locally
1. First, let's install the dependencies:  
```sh
$ bundle install
```
2. Then you should create the databases defined in the current environment, run pending migrations and fill the current database with data defined in `db/seeds.rb`:  
```sh
$ rails db:setup
```
3. Аnd now just run `bin/dev` to start the rails server and all necessary processes (redis and sidekiq):
```sh
$ bin/dev
```  
You'll use this any time you want to access your application through a web browser. Run with `--help` or `-h` for options.

### Docker-way
Just run this command in your terminal:
```sh
$ docker compose up --build
```
Run with `--help` or `-h` for options.

*Note that if the `seed` files are changed and you want to reseed database, you need to run `rake db:seed:replant` manually in the `planner_app` container. For example, you can do it like this:*
```sh
$ docker exec -it planner_app /bin/bash
```
*And then in the opened shell run:*
```sh
$ rake db:seed:replant
```

## Running Tests
### Locally
Make sure you have installed all gems by running:
```sh
$ bundle install
```
Then just run:
```sh
$ bundle exec rspec
```
And view the contents of the `coverage` folder for details (you can open `coverage/index.html` in your favourite browser to view detailed information in a convenient format).
### Docker-way
Let's start the container first by running:
```sh
$ docker compose up --build
```
Then just execute `bundle exec rspec` inside the app container:
```sh
$ docker exec -t planner_app bundle exec rspec
```
After that you can view detailed information in `coverage` folder.

## Contacts
My email skliarmikhail@gmail.com -- feel free to contact!
