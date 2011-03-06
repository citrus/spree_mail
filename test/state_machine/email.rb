# A stripped down email class for designing the structure
# of the state machine. 


require 'state_machine'

class Email 

  attr_reader :state
  attr_reader :sent_at
  
  
  state_machine :state, :initial => :layout do
          
    event :next do
      transition :layout  => :address
      transition :address => :edit
      transition :edit    => :preview
      transition :preview => :sent
    end                   
    
    event :previous do
      transition :preview => :edit
      transition :edit    => :address
      transition :address => :layout
    end    
    
    event :change_layout do
      transition :to => :layout, :if => :allow_alteration?
    end
    
    event :readdress do
      transition :to => :address, :if => :allow_alteration?
    end
    
    event :preview do
      transition :from => :edit, :to => :preview
    end
    
    event :revise do
      transition :from => :preview, :to => :edit
    end
    
    after_transition :to => :sent, :do => :deliver!

  end
  
  
  def allow_alteration?
    !sent?
  end
  
  def deliver!
    @sent_at = Time.now
  end
  
  def sent?
    !@sent_at.nil?
  end
  

end

