class User < ActiveRecord::Base
  acts_as_authentic
  
  # You'll want to run a migration like so:
  # create_table "users", :force => true do |t|
  #   t.string   "username"
  #   t.string   "name"
  #   t.string   "email"
  #   t.string   "crypted_password"
  #   t.string   "password_salt"
  #   t.string   "persistence_token"
  #   t.datetime "created_at"
  #   t.datetime "updated_at"
  # end 
end