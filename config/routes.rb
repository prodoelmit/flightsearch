Rails.application.routes.draw do
  get 'airlines', to: 'airlines#all', as: "list_airlines"
  get 'airports', to: 'airports#find', as: "find_airports"
  get 'search', to: 'flights#find', as: "find_flights"
  root to: 'home#home'
end
