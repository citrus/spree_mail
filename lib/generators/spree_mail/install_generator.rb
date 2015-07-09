module SpreeMail
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../../..", __FILE__)
      def copy_migrations
        directory "db"
      end

      def run_migrations
         res = ask "Would you like to run the migrations now? [Y/n]"
         if res == "" || res.downcase == "y"
           run 'rake db:migrate'
         else
           puts "Skiping rake db:migrate, don't forget to run it!"
         end
      end

    end
  end
end