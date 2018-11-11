Rails.application.routes.draw do
  post 'status/update'
  resources :expenses
  resources :goals

  get '/transactions/totals' => 'transactions#totals'
end
