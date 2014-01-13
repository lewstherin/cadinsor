require_dependency "cadinsor/application_controller"

module Cadinsor
  class ApiKeysController < ApplicationController

    def create
      @key = ApiKey.new
      @key.client_app_id = params[Cadinsor::Engine.config.api_key_param_name].to_i if params[Cadinsor::Engine.config.api_key_param_name]
      @key.generate_key!
      if @key.save
        respond_to do |format|
          format.json {redirect_to :action => 'show', :format => 'json', :id => @key.id}
          format.xml {redirect_to :action => 'show', :format => 'xml', :id => @key.id}
        end
      else
        respond_to do |format|
          format.json
          format.xml
        end
      end
    end

    def show
      @key = ApiKey.find_by_id(params[:id])
    end
  end
end
