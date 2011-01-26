ENV["RAILS_ENV"] = "test"

begin
  require 'rubygems'
  require 'bundler/setup'
  require 'rails/test_help'
rescue LoadError => e
	puts "Load error!"
	puts e.inspect
	exit
end


#class ActiveSupport::TestCase
#  #self.fixture_path = File.expand_path('../fixtures', __FILE__)
#end

class ActionController::TestCase
  include Devise::TestHelpers
end
