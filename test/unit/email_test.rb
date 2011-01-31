require 'test_helper'

class EmailTest < Test::Unit::TestCase

  def setup
    Subscriber.destroy_all
    Email.destroy_all
  
    setup_subscribers
  end

  should validate_presence_of(:to)
  should validate_presence_of(:subject)
  should validate_presence_of(:body)
  
  should have_readonly_attribute(:token)
  
  context "a new email" do
  
    setup do
      @email = Email.new
    end
    
    should "have default text" do
      assert !@email.body.blank?
    end
    
    should "require at least one email in to hash" do
      @email.to = { "0" => "" }
      assert !@email.valid?
      assert @email.errors.include?(:to)
    end 
    
    should "validate to hash" do
      @email.to = @to_hash
      assert !@email.valid?
      assert !@email.errors.include?(:to)
      assert_equal 2, @email.recipients.length
    end
    
    should "become a valid email" do
      @email.to = @to_hash
      @email.subject = "Spree Mail Test"
      assert @email.valid?
      assert @email.save
    end
  
  end
  
  context "an existing email" do
    
    setup do
      @email = Email.create(:to => @to_hash, :subject => "Hi {{name}}")
    end
    
    should "have recipients" do
      assert_equal 2, @email.recipients.length
    end
    
    should "make recipient list" do
      assert_equal "#{@subscriber1.email}, #{@subscriber2.email}", @email.recipient_list
    end
  
    should "render subject with mustache" do
      subject = @email.render(:subject, @subscriber1)
      assert_equal "Hi Mister Testerman", subject 
    end
    
    should "render body with mustache" do
      body = @email.render(:body, @subscriber2)
      assert_match "Hello Mailey McSampleton,", body
    end
  
  end
  
end