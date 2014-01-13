Cadinsor::Engine.routes.draw do
  get 'api_keys/create', :responds => [:json, :xml]
  get 'api_keys/show', :responds => [:json, :xml]
end
