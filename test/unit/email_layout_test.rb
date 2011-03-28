require 'test_helper'

class EmailLayoutTest < Test::Unit::TestCase

  def setup    
    @layouts = EmailLayout.all
  end
  
  should "find default layout in default directory" do
    assert_equal 1, @layouts.length
  end
  
  context "with default layout" do
    setup do
      @layout = EmailLayout.find('default')
    end
  
    should "find the default template by name" do
      assert_equal EmailLayout, @layout.class
      assert_equal File.expand_path("../../../app/views/layouts/emails/_default.html.erb", __FILE__), @layout.file
    end
  
    should "find the default image" do
      assert_equal File.expand_path("../../../public/images/mailer/default/preview.gif", __FILE__), @layout.preview_file
    end
  
  end
  
end