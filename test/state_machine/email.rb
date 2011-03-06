# A stripped down email class for designing the structure
# of the state machine. 


require 'state_machine'

class Email 

  attr_reader :state
  attr_reader :sent_at
  
  
  state_machine :state, :initial => :layout do
          
    event :next do
      transition :from => :layout,  :to => :address
      transition :from => :address, :to => :edit
      transition :from => :edit,    :to => :preview
      transition :from => :preview, :to => :sent
    end                   
    
    event :previous do
      transition :from => :preview, :to => :edit
      transition :from => :edit,    :to => :address
      transition :from => :address, :to => :layout
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

