Rails.application.routes.draw do
  resources :expenses
  resources :goals

  get '/transactions/totals' => 'transactions#totals'
end
