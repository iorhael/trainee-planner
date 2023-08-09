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
* [RVM](http://rvm.io/rvm/install)
* [Ruby 3.2.2](https://gist.github.com/pboksz/4649025)
* [Ruby on Rais 7+](https://rubygems.org/gems/rails/versions/7.0.6)
* [Bundler](https://rubygems.org/gems/bundler/versions/2.4.18)
* [PostgreSQL](https://www.postgresql.org/download/)
* [Docker](https://docs.docker.com/engine/install/)
* [Nodejs](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)
* [Yarn](https://classic.yarnpkg.com/lang/en/docs/install/#debian-stable)

(You only need [Docker](https://docs.docker.com/engine/install/) if you don't plan to run the application locally)

## Before Running

#### 1. Check out the repository
You can clone an existing repository to your local computer, or to a codespace:

```sh
$ git clone git@github.com:Iorhael/trainee-planner.git
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
2. And then in created `.env` file change the values of the variables `POSTGRES_USER` and `POSTGRES_PASSWORD` to your postgres user name and his password. Don't worry about security: this file is already in `.gitignore`.

## Running The Project
You can run the project in two ways: [Locally](#locally) or in [Docker-way](#docker-way).

### Locally
1. First, let's install the dependencies:  
```sh
$ bundle install
$ yarn install
$ yarn run build
```
2. Then you should create the databases defined in the current environment, run pending migrations and fill the current database with data defined in `db/seeds.rb`:  
```sh
$ rails db:create db:migrate db:seed
```
3. Аnd now just start the server and enjoy:  
```sh
$ rails s
```  
You'll use this any time you want to access your application through a web browser. Run with `--help` or `-h` for options.

### Docker-way
1. Build the project image:
```sh
$ docker compose build
```
2. And now is time to start and run app:
```sh
$ docker compose up
```
Run with `--help` or `-h` for options.

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
$ docker compose up --build -d
```
Then just execute `bundle exec rspec` inside the app container:
```sh
$ docker exec -it planner_app bundle exec rspec
```
After that you can view detailed information in `coverage` folder.

## Contacts
My email skliarmikhail@gmail.com -- feel free to contact!
