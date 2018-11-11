Rails.application.routes.draw do
  post 'status/update'
  resources :expenses
  resources :goals
end
