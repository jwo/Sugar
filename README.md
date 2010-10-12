RAILS 3 Template for generating a BDD style app.

Get started:

	rails new sweet -m http://github.com/jwo/Sugar/raw/master/sugar.rb

	*Edit /app/controllers/page_controller.rb, add:*
	before_filter :require_user

	*Drop into the rails console:*
	User.create(:name=>"Super Admin", :username=>"admin", :password=>"supasecret", :password_confirmation=>"supasecret", :email=>"yo@test.com")

	*rails s and ---> http://localhost:3000*
	*Login!*
		

Sugar, which is sweeeeeeeeet, will give you the following gems:

* Authlogic, from the latest source
* Paperclip
* S3
* Haml
* will_paginate
* can_can
* map_reduced (if you choose mongomapper)
* rmagick

Testing Gems

* Factory Girl
* AutoTest
* RSpec2
* Cucumber
* Cucumber-rails
* Launchy
* Webrat

Sugar, since it's sweet, will also:

* git setup
* template cleanup
* setup jquery and csrf
* Use Blueprint CSS layout system
* Show your flash messages
* Create your authlogic user session methods and controller
* Use the ChaiOne latest chaione.css awesome UI styles

TODO:

* get all in the resources and app folder, rather than loading each one specifically
* create a factories folder
* Have a pre-defined user factory