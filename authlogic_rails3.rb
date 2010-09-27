run "git clone git://github.com/binarylogic/authlogic.git vendor/gems/rails3_authlogic"
run "rm -rf vendor/gems/rails3_authlogic/.git"

open('Gemfile', 'a') { |f| f << "gem 'authlogic', :path => File.join(File.dirname(__FILE__), '/vendor/gems/rails3_authlogic')\r\n"}
  
  