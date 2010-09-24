require_statements = "require 'rails/all'"

unless @activerecord
  require_statements = <<-CODE
  require "action_controller/railtie"
  require "action_mailer/railtie"
  require "active_resource/railtie"
  CODE
end


run 'rm config/application.rb'
file "config/application.rb", <<-CODE

require File.expand_path('../boot', __FILE__)

#{require_statements}

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

if @mongomapper
file "config/initializers/mongo.rb",<<-CODE
MongoDatabase = ENV['MONGOHQ_URL'] ? ENV['MONGOHQ_URL'] : "mongodb://localhost/#{app_const_base}_\#{Rails.env}"

# MongoMapper
MongoMapper.config = {Rails.env => {'uri' => MongoDatabase}}

# MapReduced
MapReduced::Config.database = MongoDatabase
MapReduced::Config.template_path = "\#{Rails.root}/lib/mongo_functions"


MongoMapper.connect(Rails.env)
Dir[Rails.root.to_s + 'app/models/**/*.rb'].each do |model_path|
  File.basename(model_path, '.rb').classify.constantize
end
 
 
if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    # if using older than 0.6.5 of MM then you want database instead of connection
    # MongoMapper.database.connect_to_master if forked
    MongoMapper.connection.connect_to_master if forked
  end
end
CODE

end
