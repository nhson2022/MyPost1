# MyPost1

**Create new project**
```bash
rails new MyPost -c sass -j esbuild -d mysql
```

## Update database config
config/database.yml
```
default: &default
  adapter: mysql2
  encoding: utf8mb4
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  host: localhost
  port: 3306
  username: root
  password: Son@2023

development:
  <<: *default
  database: mypost1_basic_development

test:
  <<: *default
  database: mypost1_basic_test
```
## Create database
```
rails db:create
```

**Setup bootstrap**
```bash
yarn add bootstrap jquery @popperjs/core
```

Update sass config `app/assets/stylesheets/application.sass.scss`
```scss
// app/assets/stylesheets/application.sass.scss
@import "bootstrap/dist/css/bootstrap";
@import 'actiontext.css';
```

## Run App
```
./bin/dev
```

Goto page and follow instructions https://github.com/heartcombo/devise
```bash
bundle add devise
rails generate devise:install
rails g devise:views

rails generate devise User
rails db:migrate
```
NOTE: You can add name or other properties to user model

**Update config/environments/development.rb**
```rb
config.action_mailer.default_url_options = { host: 'localhost', port: 3006 }
```