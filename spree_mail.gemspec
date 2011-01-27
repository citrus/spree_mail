# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "spree_mail/version"

Gem::Specification.new do |s|
  s.name        = "spree_mail"
  s.version     = SpreeMail::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Spencer Steffen"]
  s.email       = ["spencer@citrusme.com"]
  s.homepage    = "http://github.com/citrus/spree_mail"
  s.summary     = %q{Spree Mail adds mailing list signup and delivery features.}
  s.description = %q{Spree Mail extends Spree by adding a mailing list subscriber model, sign up forms and an admin to send messages.}

  s.files        = Dir['CHANGELOG', 'README.md', 'LICENSE', 'config/**/*', 'lib/**/*', 'app/**/*', 'db/**/*', 'public/**/*', 'Rakefile']
  s.test_files   = Dir['test']
  
  s.require_paths = ["lib"]

  s.has_rdoc = false

  s.add_dependency('spree_core', '>= 0.40.2')
  s.add_dependency('spree_auth', '>= 0.40.2')
  s.add_dependency('mustache', '>= 0.12.0')
  
end