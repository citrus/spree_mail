require_relative '../test_helper'

class SubscriberTest < ActiveSupport::TestCase

  test "subscriber should validate" do
    subscriber = Subscriber.new
    assert !subscriber.valid?
  end

  test "subscriber should create" do
    subscriber = Subscriber.new(:name => "Mister Mailerman", :email => "mailerman@example.com")
    assert subscriber.valid?
    assert subscriber.save
  end

end