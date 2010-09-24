file "app/views/layouts/application.html.haml", <<-CODE
!!! XML
!!!
%html{ :lang => "en", "xml:lang" => "en", :xmlns => 'http://www.w3.org/1999/xhtml' }
	%head
		%title= @title ||= "#{app_const_base}"
		= stylesheet_link_tag :all
		= javascript_include_tag :defaults
		= csrf_meta_tag
		= yield(:header)
	%body
		#wrapper
			#header
			=flashy
			=yield
			#footer
		= yield(:footer)
CODE

run 'rm app/helpers/application_helper.rb'
file "app/helpers/application_helper.rb", File.open("#{@@base_path}resources/application_helper.rb", "rb"){|file| file.read}

run 'rm app/controllers/application_controller.rb'
file 'app/controllers/application_controller.rb', <<-CODE
class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery
end
CODE