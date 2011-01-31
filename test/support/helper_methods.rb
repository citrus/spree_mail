module HelperMethods 

  def setup_subscribers
    @subscriber1 = Subscriber.create(:name => "Mister Testerman",   :email => random_email)
    @subscriber2 = Subscriber.create(:name => "Mailey McSampleton", :email => random_email)
    @to_hash = { "0" => "", "1" => @subscriber1.email, "2" => @subscriber2.email }
  end

  def setup_email_with_subscribers
    setup_subscribers
    @email = Email.create(:to => @to_hash, :subject => "Hi {{name}}")
  end 

  def random_email
    random_token.split("").insert(random_token.length / 2, "@").push(".com").join("")
  end
  
  def random_token
    Digest::SHA1.hexdigest((Time.now.to_i * rand).to_s)
  end
  
end