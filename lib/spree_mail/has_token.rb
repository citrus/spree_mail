module SpreeMail  
  module HasToken
    
    def self.included(model)
      model.instance_eval do
        attr_readonly :token
        validates :token, :presence => true
        before_validation :set_token, :on => :create
      end
      model.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      
      def to_param
        token
      end
      
      private        
        def set_token
          write_attribute :token, Digest::SHA1.hexdigest((Time.now.to_i * rand).to_s)
        end
      
    end
    
  end
end