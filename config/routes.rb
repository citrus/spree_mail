Rails.application.routes.draw do
  
  get "/email/:token/:id", :to => "emails#show", :as => :read_email
  
  resources :subscribers, :except => [:edit,:update] do
    put :unsubscribe,  :on => :member
  end
  
  namespace(:admin) do
    resources :subscribers do 
      get :unsubscribed, :on => :collection
      get :resubscribe,  :on => :member
      get :unsubscribe,  :on => :member
    end
    resources :emails do
      get :deliver, :on => :member, :path => 'send'
    end
  end

end