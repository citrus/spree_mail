require 'digest/sha1'

class EmailLayout
  
  class << self
  
    # Gets the expanded path to the template directory
    def template_directory
      File.expand_path("../../../app/views/layouts/emails", __FILE__)
    end
    
    # Gets a list of all the email templates in the template directory
    # TODO: Add other template formats
    def all
      @layouts ||= Dir["#{template_directory}/*.html.erb"].collect{|file| EmailLayout.new(file) }
    end
  
    # Finds a layout based on it's template name
    def find(name="")
      puts "finding name #{name}"
      file = File.join(template_directory, "_#{name}.html.erb")
      puts file
      EmailLayout.new(file)
    end
  
  end
  
  
  # Returns the template file associated with the email template
  attr_reader :id, :file, :name
  
  # Creates a new instance of the email template
  def initialize(file)
    @file = file
    @name = File.basename(@file).gsub(/^_|\.html\.erb$/, '').capitalize
    @id = Digest::SHA1.hexdigest(@file)
    super
  end
  
  # Gets the expanded path to the image directory
  def image_directory
    File.expand_path("../../../public/images/mailer/#{@name.downcase}", __FILE__)
  end
  
  # Returns the path to the email layout preview image  
  def preview_file
    File.join(image_directory, "preview.gif")
  end
  
  # Returns the relative path to the email layout preview image  
  def preview_url
    "/images/mailer/#{@name.downcase}/preview.gif"
  end
  
end