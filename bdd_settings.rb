run "rm -rf test"
generate "cucumber:install", "--rspec"

drop_config = <<-CODE
config.before(:each) do  
  MongoMapper.database.collections.select { |c| c.name != 'system.indexes' }.each(&:drop)  
end
CODE

file 'spec/spec_helper.rb', <<-CODE
# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'authlogic/test_case'
include Authlogic::TestCase

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
  
  #{drop_config}
  
end
CODE
