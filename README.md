##Rails Engine

Scenario: You are working for a company developing an E-Commerce Application. Your team is working in a service-oriented architecture, meaning the front and back ends of this application are separate and communicate via APIs. Your job is to expose the data that powers the site through an API that the front end will consume.

```
RAILS_ENGINE_DOMAIN: http://localhost:3000
```
### Rails Driver
#### (Front End that consumes this project)
```
rails s -p 3001
```
#### to run the harness
```
bundle exec rspec spec/features/harness_spec.rb
```

### Setup
**Database**  
```
$ bundle exec rake import
```
**Testing**
```
$ bundle exec rspec
```

### Versions
```
  Rails 5.2.3
  Ruby 2.5.3
```
### Schema
<p align="center">
 <img src="">
</p>
