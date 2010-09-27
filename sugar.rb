@@base_path = "http://github.com/jwo/Sugar/raw/master/"

ask_orm = ask("\r\n\r\nWhat ORM framework do you want to use?\r\n\r\n(1) Active Record\r\n(2) MongoMapper Only\r\n(3) MongoMapper with ActiveRecord\r\n")
if ["1", "2", "3"].include?(ask_orm)
  @activerecord  = ["1","3"].include?(ask_orm)
  @mongomapper = ["2","3"].include?(ask_orm)
else
  puts "Woops! You must enter a number between 1 and 3"
  ask_orm
end

if @mongomapper
  ask_mongorunning = ask("\r\n\r\nDo you have mongodb running? If not, our generators for the homepage will fail. Enter (y)\r\n")
  if ask_mongorunning != "y"
    puts "Woops! You really need to run mongo"
    ask_mongorunning
  end
end

ask_css = ask("\r\n\r\nWhat css grid system framework do you want to use?\r\n\r\n(1) Blueprint\r\n(2) 960\r\n")
if ["1", "2"].include?(ask_css)
  @blueprint  = (ask_css=="1")
  @nine_sixty = (ask_css=="2")
else
  puts "Woops! You must enter a number between 1 and 2"
  ask_css
end


apply "#{@@base_path}cleanup.rb"
apply "#{@@base_path}app_config.rb"
apply "#{@@base_path}app_gems.rb"
apply "#{@@base_path}authlogic_rails3.rb"
if @mongomapper
  apply "#{@@base_path}mongo_patches.rb"
end
apply "#{@@base_path}bdd_gems.rb"
apply "#{@@base_path}jquery.rb"
apply "#{@@base_path}static_resources.rb"
apply "#{@@base_path}layouts.rb"
apply "#{@@base_path}generators.rb"
run "bundle install"
apply "#{@@base_path}static_home.rb"
apply "#{@@base_path}bdd_settings.rb"
apply "#{@@base_path}controllers.rb"
apply "#{@@base_path}models.rb"
apply "#{@@base_path}views.rb"
apply "#{@@base_path}git_setup.rb"

if @activerecord 
  run "rake db:migrate"
end