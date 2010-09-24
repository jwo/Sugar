#----------------------------------------------------------------------------
# Remove unnecessary Rails files
#----------------------------------------------------------------------------
run 'rm README'
run 'rm public/index.html'
run 'rm public/images/rails.png'
run 'rm .gitignore'
run 'rm app/views/layouts/application.html.erb'
run 'rm Gemfile'
file 'Gemfile', <<-CODE
source 'http://gemcutter.org'
source 'http://rubygems.org'
CODE
run 'touch README'