User.instance_eval do
  
  def to_subscribers!
    new_subscribers = []
    emails = Subscriber.select('email').all.collect(&:email)
    users = User.includes(:bill_address).select('bill_address.firstname, email')
    users = users.where("email NOT IN (?)", emails) unless emails.empty?
    users.each do |user|
      next if user.email =~ /@example\.(com|net|org)$/
      name  = user.bill_address.firstname unless user.bill_address.nil?
      name  = (name.nil? || name.to_s.strip.empty?) ? "Subscriber" : name
      new_subscribers << { :name => name, :email => user.email }
    end
    new_subscribers = Subscriber.create(new_subscribers) unless new_subscribers.empty?
    new_subscribers.length
  end

end