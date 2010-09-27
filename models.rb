file "app/models/user_session.rb", <<-CODE
class UserSession < Authlogic::Session::Base
end
CODE

if @activerecord
  user_file_name = "ar_user"
  generate "model users username:string name:string email:string crypted_password:string password_salt:string persistence_token:string"
else
  user_file_name = "mongo_user"
end

run "rm app/models/#{user_file_name}.rb"
file "app/models/user.rb", open("#{@@base_path}app/models/#{user_file_name}.rb", "rb"){|file| file.read}