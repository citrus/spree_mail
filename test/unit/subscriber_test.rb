require_relative '../test_helper'

class SubscriberTest < Test::Unit::TestCase

  def setup
    Subscriber.destroy_all
  end

  should allow_value(random_email).for(:email)
  should_not allow_value("invalid#email").for(:email)
  should have_readonly_attribute(:token)
  
  context "a new subscriber" do
    
    setup do
      @new_subscriber = Subscriber.new
    end
    
    should "be invalid" do
      assert !@new_subscriber.valid?
    end
    
    should "have one error" do
      @new_subscriber.valid?
      assert_equal 1, @new_subscriber.errors.length
    end
    
    should "create a random token" do
      @new_subscriber.valid?
      token1 = @new_subscriber.token
      @new_subscriber.valid?
      assert_not_equal token1, @new_subscriber.token
    end
    
    should "save new subscriber" do
      @new_subscriber.update_attributes(:name => "Mister Testman", :email => random_email)
      assert @new_subscriber.valid?
      assert @new_subscriber.save
    end
    
  end
  
  context "an existing subscriber" do
  
    setup do
      @subscriber = Subscriber.create(:name => "Mister Testerman", :email => random_email)
    end
    
    should "be an active subscriber" do
      assert @subscriber.active?
    end
  
    should "unsubscribe" do
      assert @subscriber.active?, "Should be subscribed"
      @subscriber.unsubscribe!
      assert !@subscriber.active?, "Should be unsubscribed"
    end
  
    should "resubscribe" do
      @subscriber.unsubscribe!
      assert !@subscriber.active?, "Should be unsubscribed"
      @subscriber.resubscribe!
      assert @subscriber.active?, "Should be subscribed"
    end
  
    should "be destroyed" do
      assert @subscriber.destroy
    end
    
  end
  
end