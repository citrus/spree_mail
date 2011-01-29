ENV["RAILS_ENV"] = "test"

root = ENV["RAILS_ROOT"] || File.expand_path('../../spec/test_app', __FILE__)
env = File.join(root, 'config', 'environment.rb')
puts "(Rails Root: #{root})"
require env

begin
  require 'rubygems'
  require 'bundler/setup'
rescue LoadError => e
	puts "Load error!"
	puts e.inspect
	exit
end

#class ActiveSupport::TestCase
#  #self.fixture_path = File.expand_path('../fixtures', __FILE__)
#end

class ActionController::TestCase
  #include Devise::TestHelpers
end
