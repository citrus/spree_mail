require 'mustache'
require 'spree_mail/version'
require 'spree_mail/custom_hooks'

module SpreeMail
  
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    #initializer "static assets" do |app|
    #  app.middleware.insert_before ::Rack::Lock, ::ActionDispatch::Static, "#{config.root}/public"
    #end

    #def self.activate
    #  #Dir["../app/**/*.rb"].each do |c|
    #  #  puts c
    #  #  #Rails.env.production? ? require(c) : load(c)
    #  #end
    #end

    #config.to_prepare &method(:activate).to_proc
  end
end