# Setup our Gems
gem "rails", "3.0.1"

if @mongomapper
  gem 'mongo_mapper', "=0.8.4"
  gem "bson", "=1.1.1"
  gem "bson_ext", "=1.1.1"
  gem "bcrypt-ruby", :require => "bcrypt"
  gem "map_reduced",">= 0.1.1"
end

if @activerecord
  gem 'sqlite3-ruby', :require => 'sqlite3'
end

gem 'haml'
gem "paperclip", "=2.3.3"
gem "cancan"
gem "aws-s3"
gem "rmagick"
gem "will_paginate", "~> 3.0.pre2"
