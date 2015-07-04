# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'spree_mail/version'

Gem::Specification.new do |s|
  s.name        = 'spree_mail'
  s.version     = SpreeMail::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Spencer Steffen', 'Alberto Vena']
  s.email       = ['spencer@citrusme.com']
  s.homepage    = 'http://github.com/citrus/spree_mail'
  s.summary     = %q{Spree Mail adds mailing list signup and delivery features.}
  s.description = %q{Spree Mail extends Spree by adding a mailing list subscriber model, sign up forms and an admin to send messages.}

  s.files        = Dir['AUTHORS', 'README.md', 'LICENSE', 'config/**/*', 'lib/**/*', 'app/**/*', 'db/**/*', 'public/**/*', 'Rakefile']
  s.test_files   = Dir['test']
  
  s.require_paths = ['lib']

  s.add_dependency 'spree_core', '> 2.4.6'
  s.add_dependency('mustache',    '>= 0.12.0')
  s.add_dependency('mail',        '>= 2.2.0')
  s.add_dependency('meta_search', '>= 1.0.1')
  
	s.add_development_dependency('shoulda',            '>= 2.11.3')
	s.add_development_dependency('capybara',           '>= 0.4.1')
	s.add_development_dependency('selenium-webdriver', '>= 0.1.3')
  s.add_development_dependency('spork',              '>= 0.9.0.rc5')
  s.add_development_dependency('spork-testunit',     '>= 0.0.5')
  s.add_development_dependency('sqlite3',            '>= 1.3.3')
	
end