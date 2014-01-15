Rails.application.routes.draw do
  mount Cadinsor::Engine => "/cadinsor"
  get ':controller(/:action(/:id))(.:format)'
end
