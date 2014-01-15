require_dependency "cadinsor/application_controller"

module Cadinsor
  class ApiKeysController < ApplicationController

    def create
      @key = ApiKey.new
      @key.client_app_id = params[Cadinsor::Engine.config.api_key_param_name].to_i if params[Cadinsor::Engine.config.api_key_param_name]
      @key.generate_key!
      if @key.save
        respond_to do |format|
          format.json {redirect_to :action => 'show', :format => 'json', :key => @key.key}
          format.xml {redirect_to :action => 'show', :format => 'xml', :key => @key.key}
        end
      else
        respond_to do |format|
          format.json
          format.xml
        end
      end
    end

    def show
      if params[:key]
        @key = ApiKey.find_by_key(params[:key])
      end
    end
  end
end
