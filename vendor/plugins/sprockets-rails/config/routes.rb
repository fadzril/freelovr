Rails.application.routes.draw do
  resources :sprockets, :only => [:show]
end
