controllers = %w{application_controller user_sessions_controller}

controllers.each do |controller_file_name|
  run "rm app/controllers/#{controller_file_name}.rb"
  file "app/controllers/#{controller_file_name}.rb", File.open("#{@@base_path}app/controllers/#{controller_file_name}.rb", "rb"){|file| file.read}
end

route "resource :user_sessions"
route "match 'login' => 'user_sessions#new', :as => :login"
route "match 'logout' => 'user_sessions#destroy', :as => :logout"