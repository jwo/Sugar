run 'rm config/application.rb'
file "config/application.rb", <<-CODE

require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module #{app_const_base}
  class Application < Rails::Application
    config.encoding = "utf-8"


    config.generators do |g|
      g.template_engine :haml
      g.test_framework  :rspec, :fixture => false
    end
    
    config.filter_parameters += [:password, :password_confirmation]
  end
end

CODE