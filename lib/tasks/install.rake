namespace :spree_mail do

  desc "Converts all current users into subscribers if they're not already"
  task :subscribe_users do
    require File.join(Rails.root, "config/environment")
    require 'spree_mail/user_extension'
    count = User.to_subscribers!
    puts 0 < count ? "#{count} users are now subscribers." : "No new subscribers were created."
  end
  
  desc "Copies all migrations (NOTE: This will be obsolete with Rails 3.1)"
  task :install do
    Rake::Task['spree_mail:install:migrations'].invoke
  end
  
  namespace :install do
    desc "Copies all migrations (NOTE: This will be obsolete with Rails 3.1)"
    task :migrations do
    
      source = File.expand_path('../../../db/migrate', __FILE__)
      destination = File.join(Rails.root, 'db', 'migrate')
      
      FileUtils.mkdir_p(destination)
      
      migrations = Dir.entries(destination).select{|file| file.match('.rb') }
      
      files = Dir.entries(source).select{|file| file.match('.rb') }
      files.each_with_index do |file,index|
        time = Time.now + (index * 7)
        number = [time.utc.strftime("%Y%m%d%H%M%S"), "%.14d" % index].max
        new_file = [number,file].join('_')
        src = File.join(source, file)
        dst = File.join(destination, new_file)
        if 0 < migrations.select{|migration| migration.match(file) != nil }.length
          puts "#{file} exists!"
        else
          FileUtils.cp(src, dst)
          puts "#{new_file} copied!"
        end
      end
    end
  end

end