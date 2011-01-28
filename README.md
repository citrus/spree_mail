Spree Mail
----------

Spree Mail is a complete email marketing extension for Spree. Visitors can sign up for the mailing list by visiting the new subscriber page and admins can create and send emails to selected subscribers. Subscribers can view emails online and unsubscribe if they wish.

To customize Spree Mail's html template, copy `email.html.erb` to your local layouts folder.


Demo
----

To create a spree mail demo app, run the following:
  
    rails new spree_mail_example 
    cd spree_mail_example 
    echo "gem 'spree', '0.40.2'" >> Gemfile 
    echo "gem 'spree_mail', '0.40.0.2'" >> Gemfile 
    rm public/index.html 
    bundle install 
    rake spree:install spree_mail:install db:migrate db:seed


Or all at once:

    rails new spree_mail_example; cd spree_mail_example; echo "gem 'spree', '0.40.2'" >> Gemfile; echo "gem 'spree_mail', '0.40.0.2'" >> Gemfile; rm public/index.html; bundle install; rake spree:install spree_mail:install db:migrate db:seed

`rake db:sample` if you want to...

Then start the server with `rails s`


Before sending, you may need to create an action_mailer initializer.

    # config/initializers/action_mailer.rb

    ActionMailer::Base.delivery_method = :sendmail
    ActionMailer::Base.sendmail_settings = {
      :arguments => '-r no-reply@spree-mail-example.com'
    }


To Do
-----

* Write real tests 
* Write a rake task that converts current users to subscribers
* Add checkbox on user signup: 'sign up for our mailing list'
* Add user help to email form
* Add email tracking functionality
* Add a selection of products to emails
* Add an 'assets' upload admin and an easy way to link images or files to an email
* Maybe add a wysiwyg editor for email composition


License
-------

Copyright (c) 2011 Spencer Steffen, released under the New BSD License All rights reserved.