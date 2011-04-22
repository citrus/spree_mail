require_relative '../test_helper'

class UserExtensionTest < Test::Unit::TestCase

  US = Country.find_by_iso("US") || Country.create(:iso_name => "UNITED STATES", :iso => "US", :name => "United States", :iso3 => "USA", :numcode => 840)
  CA = State.find_by_abbr("CA") || State.create(:name =>  "California", :abbr => "CA", :country => US) 

  def setup
    Subscriber.destroy_all
    User.destroy_all
    10.times{|i| build_user(i) }
    @users = User.all
  end
  
  def build_user(i, params={})
    params[:user] ||= {}
    params[:address] ||= {}
    user = User.new({ :email => random_email, :password => "password", :password_confirmation => "password" }.merge(params[:user]))
    user.bill_address = Address.new({
      :firstname => "Billy #{i}",
      :lastname  => "McWilly",
      :address1  => "12#{i + 10} State St",
      :city      => "Santa Barbara",
      :zipcode   => "93101",
      :state     => CA,
      :country   => US,
      :phone     => "555-555-#{1000 + (i * 123)}"
    }.merge(params[:address]))
    user.save ? user : false
  end
  
  
  
      
  should "confirm no subscribers and 10 users" do
    assert_equal 0,  Subscriber.count
    assert_equal 10, @users.length
  end
  
  should "throw undefined method error" do
    assert_raises NoMethodError do
      User.to_subscribers!
    end
  end
  
  context "when user extension is loaded" do
    
    setup do
      require 'spree_mail/user_extension'
    end
    
    should "convert users to subscribers" do
      User.to_subscribers!
      assert_equal 10, @users.length
      assert_equal 10, Subscriber.count
    end
    
    should "skip users with `example.net` domain" do
      build_user 11, :user => { :email => "something@example.net" }
      assert_equal 11, User.count
      User.to_subscribers!      
      assert_equal 10, Subscriber.count
    end
    
  end
end