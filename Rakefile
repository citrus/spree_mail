require 'bundler'
require 'rake/testtask'
Bundler::GemHelper.install_tasks

Rake::TestTask.new do |t|
  t.libs << "lib"
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end


#task :test do
#
#  root = ENV["RAILS_ROOT"] || File.expand_path('../spec/test_app', __FILE__)
#  env = File.join(root, 'config', 'environment.rb')
#  puts "(Rails Root: #{root})"
#
#  require env
#  require File.expand_path('../test/test_helper', __FILE__)
#  Dir["test/**/*.rb"].reject{|file| file.match(/test_helper/) != nil }.each do |file|
#    puts "Loading #{file}"
#    load file
#  end
#  
#end
#



desc "Default Task"
task :default => [ :test ]








# TODO: pull in the spree/core/Rakefile bits that set up for testing
desc "Regenerates a Rails 3 app for testing"
task :test_app do
# TODO - this path requires a certain directory structure -- need
# to think about how to refactor
  
  
  files = `gem contents spree`.split("\n").select{|file| file.match("test_app_generator")}
  if files.length == 1
    require files.first
    class SpreeMailTestAppGenerator < Spree::Generators::TestAppGenerator
      def tweak_gemfile
        append_file "Gemfile" ,
          <<-gems
gem 'activemerchant'
gem 'spree_core', '>=0.40.2'
gem 'spree_auth', '>=0.40.2'
gem 'spree_mail', :path => "#{File.dirname(__FILE__)}"  
          gems
      end
  
      def install_spree_gems
      
        puts "-----------------------------------------"
        puts "Installing gems..."
        `bundle install --gemfile=spec/test_app/Gemfile`
        puts "-----------------------------------------"
      
        inside "test_app" do
          run 'rake spree_core:install'
          run 'rake spree_auth:install'
          run 'rake spree_mail:install'
        end
      end
    
      def migrate_db
        run_migrations
      end
    end
    
    SpreeMailTestAppGenerator.start
    
    puts "spec/test_app created. "
           
  else
    puts "Failed: Could not find lib/generators/spree/test_app_generator.rb"
  end
end

namespace :test_app do
  desc 'Rebuild test database'
  task :rebuild_db do
    system("cd spec/test_app && rake db:drop db:migrate RAILS_ENV=test")
  end
end
