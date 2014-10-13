Rails.application.routes.draw do

  # ex: /stores/geo.json?sw=40.767097,-73.956244&ne=45.803496,-70.789849
  get 'stores/geo'

  # ex: /parkings/geo.json?sw=40.767097,-73.956244&ne=45.803496,-70.789849
  get 'parkings/geo' => 'parkings#geo'

  resources :parkings, only: [:index, :show]

  resources :stores, only: [:index, :show]

end
