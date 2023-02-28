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

**Update app/views/layouts/application.html.erb**
```html
<div class="container">
<% if notice.present? %>
<div class="alert alert-primary mt-4" role="alert">
<%= notice %>
</div>
<% end %>

<% if alert.present? %>
<div class="alert alert-danger mt-4" role="alert">
<%= alert %>
</div>
<% end %>

<%= yield %>
</div>
```

## Setup Active Storage
```
bin/rails active_storage:install
bin/rails db:migrate
```

## Setup Action Text
```
bin/rails action_text:install
bin/rails db:migrate
```

## Create controller pages home and info**
```bash
rails g controller pages home
```

## Create Post
```bash
rails g scaffold Post content user:references
bin/rails db:migrate
```

ERD Tools
- https://app.diagrams.net/

## Following User
```bash
rails generate model Relationship follower_id:integer:index followed_id:integer:index

# update migration and add combine unique index
add_index :relationships, [:follower_id, :followed_id], unique: true

bin/rails db:migrate
```

Refs:
- https://guides.rubyonrails.org/association_basics.html#the-has-many-through-association

**Following - Followed users**
```rb
# app/models/user.rb
has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
has_many :following, through: :active_relationships, source: :followed
```

SQL query to get following users
```sql
SELECT `users`.* FROM `users`
INNER JOIN `relationships` ON `users`.`id` = `relationships`.`followed_id`
WHERE `relationships`.`follower_id` = 1
```

**Followers - Follower users**
```rb
# app/models/user.rb
has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
has_many :followers, through: :passive_relationships, source: :follower
```

**Implement follow, unfollow methods**
```rb
# models/user.rb

# Follows a user.
def follow(other_user)
return if other_user.id == id

if following?(other_user)
unfollow(other_user)
return
end

following << other_user
end

# Unfollows a user.
def unfollow(other_user)
following.delete(other_user)
end

# Returns true if the current user is following the other user.
def following?(other_user)
following.include?(other_user)
end

def name
"#{first_name} #{last_name}"
end

def self.available_users(current_user)
return all unless current_user.present?

where.not(id: current_user.id)
end

```

**Create profile page**
```
rails g controller profiles show my
```
