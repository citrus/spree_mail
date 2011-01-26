Rails.application.routes.draw do
  
  resources :subscribers
  
  namespace(:admin) do
    resources :subscribers
    resources :emails
  end

end
