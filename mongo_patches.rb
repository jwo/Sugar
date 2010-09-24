initializer 'a_paperclip', <<-CODE
module Paperclip
  module ClassMethods
    def has_attached_file name, options = {}
      include InstanceMethods

      write_inheritable_attribute(:attachment_definitions, {}) if attachment_definitions.nil?
      attachment_definitions[name] = {:validations => []}.merge(options)

      after_save :save_attached_files
      before_destroy :destroy_attached_files

      define_callbacks :before_post_process, :after_post_process
      define_callbacks :"before_\#{name}_post_process", :"after_\#{name}_post_process"
     
      define_method name do |*args|
        a = attachment_for(name)
        (args.length > 0) ? a.to_s(args.first) : a
      end

      define_method "\#{name}=" do |file|
        attachment_for(name).assign(file)
      end

      define_method "\#{name}?" do
        attachment_for(name).file?
      end

      validates_each name, :logic => lambda {
        attachment = attachment_for(name)
        attachment.send(:flush_errors) #unless attachment.valid?
      }
    end
  end

  module Interpolations
    # Handle string ids (mongo)
    def id_partition attachment, style
      if (id = attachment.instance.id).is_a?(Integer)
        ("%09d" % id).scan(/\d{3}/).join("/")
      else
        id.scan(/.{3}/).first(3).join("/")
      end
    end
  end
  
  class Attachment
      # Somehow the :updated_at field gets returned as Date even if its key is a DateTime or Time...
      def updated_at
        time = instance_read(:updated_at).to_time
        time && time.to_f.to_i
      end
    end
end

ActiveRecord::Base.logger = Rails.logger
CODE

initializer 'authmonkey', <<-CODE
# Monkeypatch to use a validates_numericality_of that MongoMapper's validation
# library understands (no :greater_than_or_equal_to option).
module Authlogic::ActsAsAuthentic::MagicColumns::Methods
  def self.included(klass)
    klass.class_eval do
      validates_numericality_of :login_count, :allow_nil => true if column_names.include?('login_count')
      validates_numericality_of :failed_login_count, :allow_nil => true if column_names.include?('failed_login_count')
    end
  end
end

# Monkeypatch to use save(:validate => false) instead of save(false)
module Authlogic::Session::Callbacks
  def save_record(alternate_record = nil)
    r = alternate_record || record
    r.save_without_session_maintenance(:validate => false) if r && r.changed? && !r.readonly?
  end
end

module AuthlogicPlugin
  def self.configure(model)
    model.class_eval do
      attr_protected :crypted_password, :password_salt, :persistence_token

      key :username, String
      key :email, String
      key :crypted_password, String
      key :password_salt, String
      key :persistence_token, String
      key :login_count, Integer, :default => 0
      key :last_request_at, Time
      key :last_login_at, Time
      key :current_login_at, Time
      key :last_login_ip, String
      key :current_login_ip, String

      include Authlogic::ActsAsAuthentic::Base
      include Authlogic::ActsAsAuthentic::Email
      include Authlogic::ActsAsAuthentic::LoggedInStatus
      include Authlogic::ActsAsAuthentic::Login
      include Authlogic::ActsAsAuthentic::MagicColumns
      include Authlogic::ActsAsAuthentic::Password
      include Authlogic::ActsAsAuthentic::PerishableToken
      include Authlogic::ActsAsAuthentic::PersistenceToken
      include Authlogic::ActsAsAuthentic::RestfulAuthentication
      include Authlogic::ActsAsAuthentic::SessionMaintenance
      include Authlogic::ActsAsAuthentic::SingleAccessToken
      include Authlogic::ActsAsAuthentic::ValidationsScope
    end
  end

  module ClassMethods
    def <(klass)
      return true if klass == ::ActiveRecord::Base
      super(klass)
    end

    def quoted_table_name
      'users'
    end

    def primary_key
      # This check might not be needed, but doesn't hurt to be sure (does
      # MM define a primary_key classmethod?)
      if caller.first.to_s[/(persist|session)/]
        :"_id"
      else
        super
      end
    end

    def default_timezone
      :utc
    end

    def find_by__id(*args)
      find_by_id *args
    end

    def find_with_case(field, value, sensitivity = true)
      where(field=>value).first
    end

    def with_exclusive_scope(query)
      query = where(query) if query.is_a?(Hash)
      yield query
    end

    def with_scope(query)
      with_exclusive_scope(query) {|*block_args| yield(*block_args)}
    end

    def named_scope(*args, &block)
      scope *args, &block
    end
  end

  module InstanceMethods
    def readonly?
      false
    end
    
    def username=(new_username)
      new_username.downcase! unless new_username.nil?
      write_attribute(:username, new_username)
    end
  end
end
CODE

unless @activerecord
  run 'rm spec/spec_helper.rb'
  file 'spec/spec_helper.rb', <<-CODE
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec

  end
  
CODE
  
end