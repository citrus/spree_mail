Rails.application.routes.draw do
  
  get "/email/:subscriber/:email", :to => "emails#show", :as => :read_email
  get "/subscribers" => redirect("/subscribers/new")
  
  resources :subscribers, :except => [:index,:edit,:update] do
    put :unsubscribe,  :on => :member
    put :resubscribe,  :on => :member
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