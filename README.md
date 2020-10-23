# Rails Engine
### BE Mod 3 Week 3 Solo Project

### Developed By:

#### [Chris Allbritton](https://github.com/Callbritton)

## Background and Description

"Rails Engine"/"Rails Driver" is a mock E-Commerce Application that utilizes service-oriented architecture, where the backend (Rails Engine) and the front end (Rails Driver) communicate via APIs. The primary purpose of the project is to expose the data (via Rails Engine) that powers the "site" through an API that the front end will consume.

## Learning Goals

- Expose an API ⭐ ⭐ ⭐
- Use serializers to format JSON responses ⭐ ⭐ ⭐
- Test API exposure ⭐ ⭐ ⭐
- Compose advanced ActiveRecord queries to analyze information stored in SQL databases ⭐ ⭐
- Write basic SQL statements without the assistance of an ORM ⭐

## Schema
<img width="800" height="600" alt="Schema Light Screenshot" src="/app/assets/images/Rails Engine Schema.png">

## Setup

This project utilizes two separate Rails applications:
Both projects require:
- Ruby 2.5.3.
- Rails 5.2.4.3

### Setup Rails Engine:

* Fork this [repository](https://github.com/Callbritton/rails_engine)
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle install`
    * `rails db:create`
    * `rails db:migrate`
    * `rails import`

### Setup Rails Driver

* Clone [Rails Driver](https://github.com/turingschool-examples/rails_driver)
* From the command line, install gems and set up your DB:
    * `bundle install`
    * `rails db:create`
    * `rails db:migrate`
    * `figaro install`

## Testing

### Test Rails Engine:
* CD into the Rails Engine directory
* Run the test suite with `bundle exec rspec`.

### Test the Spec Harness In Rails Driver:
* Within the Rails Engine app run your development server with `rails s`.
* While the Rails Engine server is running, and in a separate terminal tab (`cmd+t`), `cd` into the Rails Driver directory.
* Once the Rails Engine server is running, from within the Rails Driver directory run the test suite with `bundle exec rspec`
* At this time there should be 1 failing test!
