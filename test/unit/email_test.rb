require 'test_helper'

class EmailTest < Test::Unit::TestCase

  def setup
    Subscriber.destroy_all
    Email.destroy_all
  
    setup_subscribers
  end

  should have_readonly_attribute(:token)
  
  context "a new email" do
  
    setup do
      @email = Email.new
    end
    
    subject do
      @email = Email.new
    end
    
    should_not validate_presence_of(:to)  
    should_not validate_presence_of(:subject)
    should_not validate_presence_of(:body)
  
    should "have default text" do
      assert !@email.body.blank?
    end
    
  end
  
    
  context "an email in address state" do
          
    setup do
      @email = Email.new(:state => "address")
    end
    
    subject do 
      @email
    end
    
    should validate_presence_of(:to)
      
    should "validate to hash" do
      @email.to = { "0" => "" }
      assert_equal "address", @email.state
      assert !@email.valid?
      assert @email.errors.include?(:to)
    end
    
    should "becomve valid" do
      @email.to = @to_hash
      assert @email.valid?
      assert !@email.errors.include?(:to)
    end

    context "after save" do
      setup do
        @email.to = @to_hash        
        @email.save
      end
      
      should "have recipients" do
        assert_equal 2, @email.recipients.length
      end
      
      should "make recipient list" do
        assert_equal "#{@subscriber1.email}, #{@subscriber2.email}", @email.recipient_list
      end
      
    end
    
    
    context "an email in edit state" do
      
      subject do
        Email.new(:to => @to_hash, :state => "edit")
      end
    
      should validate_presence_of(:subject)
      should validate_presence_of(:body)
      
    end
    
  
  
    context "an email in preview state" do
  
      setup do
        @email = Email.create(:to => @to_hash, :subject => "Hi {{name}}", :body => "Hello {{name}}", :state => "preview")
      end
      
      should "render subject with mustache" do
        subject = @email.render(:subject, @subscriber1)
        assert_equal "Hi Mister Testerman", subject 
      end
      
      should "render body with mustache" do
        body = @email.render(:body, @subscriber2)
        assert_match "Hello Mailey McSampleton", body
      end
  
    end
    
  end
  
end