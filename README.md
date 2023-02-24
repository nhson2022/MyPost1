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