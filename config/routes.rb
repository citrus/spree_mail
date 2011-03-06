Rails.application.routes.draw do
  
  get "/email/:subscriber/:email", :to => "emails#show", :as => :read_email
  get "/subscribers" => redirect("/subscribers/new")
  
  resources :subscribers, :except => [:index,:edit,:update] do
    put :unsubscribe,  :on => :member
  end
  
  namespace(:admin) do
    resources :subscribers do 
      get :unsubscribed, :on => :collection
      get :resubscribe,  :on => :member
      get :unsubscribe,  :on => :member
    end
    
    get '/email/:state', :to => 'emails#edit', :state => /layout|address|edit|preview/, :as => :email_state
    resources :emails do
      get :deliver, :on => :member, :path => 'send'
    end
    

    resources :email_layouts
  end

end