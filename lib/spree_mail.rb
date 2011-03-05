require 'spree_core'
require 'spree_auth' 

require 'mail'
require 'mustache'
require 'meta_search'
require 'spree_mail/custom_hooks'
require 'spree_mail/has_token'

module SpreeMail
  
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    initializer "static assets" do |app|
      app.middleware.insert_before ::Rack::Lock, ::ActionDispatch::Static, "#{config.root}/public"
    end

  end
  
end