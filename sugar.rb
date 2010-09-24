@@base_path = "/Users/jwo/chaione/sugar/"

apply "#{@@base_path}cleanup.rb"
apply "#{@@base_path}app_config.rb"
apply "#{@@base_path}app_gems.rb"
apply "#{@@base_path}bdd_gems.rb"
apply "#{@@base_path}bdd_settings.rb"
apply "#{@@base_path}jquery.rb"
apply "#{@@base_path}layouts.rb"
run "git clone git://github.com/psynix/rails3_haml_scaffold_generator.git lib/generators/haml"
apply "#{@@base_path}static_home.rb"
run "bundle install"

generate "rspec"
generate "cucumber"

apply "#{@@base_path}git_setup.rb"