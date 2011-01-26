Spree Mail
----------

Spree Mail extends Spree by adding a mailing list subscriber model, sign up forms and an admin to send messages.



Demo
----

rails new spree_mail_example; cd spree_mail_example; echo "gem 'spree', '0.40.2'" >> Gemfile; echo "gem 'spree_mail', :path => '~/RoR/gems'" >> Gemfile; rm public/index.html; bundle install; rake spree:install spree_mail:install db:migrate db:seed; rails s




License
-------

Copyright (c) 2011 Spencer Steffen, released under the New BSD License All rights reserved.