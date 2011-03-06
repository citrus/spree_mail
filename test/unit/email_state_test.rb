require 'test_helper'

class EmailStateTest < Test::Unit::TestCase

  
  def setup
    @email = Email.new(:subject => "testing 123", :body => "Hello {{name}}")
    
    #puts @email.state
    #
    #
    #puts @email.inspect
    #
    #puts @email.next!
    #
    #puts @email.state
    #
    
  end
  
  should "advance to :layout" do
    assert_equal "layout", @email.state
  end
  
  should "advance to :address" do
    @email.next!
    assert_equal "address", @email.state
  end
  
  context "an existing, un-sent email" do
      
    setup do
      2.times{ @email.next! }
    end  
  
    should "advance to :edit" do
      assert_equal "edit", @email.state
    end
  
    should "return to :address" do
      @email.readdress!
      assert_equal "address", @email.state
    end
    
    should "return to :address" do
      @email.previous!
      assert_equal "address", @email.state
    end
    
    should "return to :layout" do
      2.times{ @email.previous! }
      assert_equal "layout", @email.state
    end
    
    should "advance to :preview" do
      @email.next!
      assert_equal "preview", @email.state
    end
    
  end
  
  context "a sent email" do
    
    setup do
      4.times{ 
        @email.next! 
        puts @email.state
      }
    end
    
    should "not be editable" do
      assert_raises StateMachine::InvalidTransition do
        @email.previous!
      end
      assert_raises StateMachine::InvalidTransition do
        @email.revise!
      end
      assert_raises StateMachine::InvalidTransition do
        @email.readdress!
      end
      assert_raises StateMachine::InvalidTransition do
        @email.change_layout!
      end
    end
    
  end
  
end