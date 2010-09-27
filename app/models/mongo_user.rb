class User
  include MongoMapper::Document
  plugin AuthlogicPlugin
  key :name, String, :required => true
  key :single_access_token, String
  key :perishable_token, String
  acts_as_authentic do |config|
    config.login_field = 'username'
    config.instance_eval do
      validates_uniqueness_of_login_field_options :scope => '_id', :case_sensitive => true
    end
  end
  attr_protected :single_access_token, :perishable_token, :confirmed
  timestamps!
  
end