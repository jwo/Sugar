blueprint_css = <<-BLUE
\t\t= stylesheet_link_tag "blueprint/screen"
\t\t= stylesheet_link_tag "blueprint/print", {:media=>:print} 
\t\t/[if IE]
\t\t\t= stylesheet_link_tag "blueprint/ie"
BLUE

nine_sixty_css = <<-BLUE
\t\t= stylesheet_link_tag "css/reset"
\t\t= stylesheet_link_tag "css/text"
\t\t= stylesheet_link_tag "css/960"
BLUE


file "app/views/layouts/application.html.haml", <<-CODE
!!! XML
!!!
%html{ :lang => "en", "xml:lang" => "en", :xmlns => 'http://www.w3.org/1999/xhtml' }
	%head
		%title= @title ||= "#{app_const_base}"
#{nine_sixty_css if @nine_sixty}#{blueprint_css if @blueprint}
\t\t= stylesheet_link_tag :all
\t\t= javascript_include_tag :defaults
\t\t= csrf_meta_tag
\t\t= yield(:header)
	%body
		#wrapper.container.container_16
			#header
			=flashy
			=yield
			#footer
		= yield(:footer)
CODE

run 'rm app/helpers/application_helper.rb'
file "app/helpers/application_helper.rb", open("#{@@base_path}resources/application_helper.rb", "rb"){|file| file.read}

initializer 'haml.rb', "Haml::Template.options[:format] = :xhtml"