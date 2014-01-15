module Cadinsor
  module Extensions

    def check_request_with_cadinsor(options = {})
      options[:target_params] ? target_params = options[:target_params] : target_params = params
      target_params = cadinsor_flatten_params(target_params)
      api_key = target_params[Cadinsor::Engine.config.api_key_param_name]
      signature = target_params[Cadinsor::Engine.config.request_signature_param_name]
      client_app_id = target_params[Cadinsor::Engine.config.client_app_id_param_name]
      cadinsor_validate_key(api_key) if options[:ignore_key] != true
      cadinsor_validate_app(client_app_id)
      cadinsor_validate_signature(target_params, signature, Cadinsor::Engine.config.client_app_id_param_name, Cadinsor::Engine.config.request_signature_param_name)
    end

    def cadinsor_flatten_params(parameter_hash, key_prefix = "")
      flattened_hash = {}
      parameter_hash.keys.each do |key|
        if parameter_hash[key].is_a? Hash
          key_prefix == "" ? flatten_prefix = key.to_s : flatten_prefix = key_prefix + "_" + key.to_s
          flattened_hash.merge! cadinsor_flatten_params(parameter_hash[key], flatten_prefix)
        else
          key_prefix == "" ? flattened_hash.merge!({key => parameter_hash[key]}) : flattened_hash.merge!({(key_prefix.to_s + "_" + key.to_s).to_sym => parameter_hash[key]})
        end
      end
      flattened_hash
    end

    def cadinsor_validate_key(api_key)
      raise Cadinsor::Extensions::RequestError.new "Invalid Request. Key not present in request." if api_key.to_s == ""
      key = Cadinsor::ApiKey.find_by_key(api_key)
      raise Cadinsor::Extensions::RequestError.new "Invalid Request. Key is not valid." if !key
      raise Cadinsor::Extensions::RequestError.new "Invalid Request. Key has expired. Please use a new key." if key.expired?
    end

    def cadinsor_rescue(message)
      @cadinsor_error_message = message
      respond_to do |format|
        format.json {render "cadinsor/application/cadinsor_error_response", format: 'json'}
        format.xml {render "/cadinsor/application/cadinsor_error_response", format: 'xml'}
      end
    end

    def cadinsor_validate_app(app_id)
      raise Cadinsor::Extensions::RequestError.new "Invalid Request. Client App id is not present in request." if app_id.to_s == ""
      app = Cadinsor::ClientAPP.find_by_id(app_id)
      raise Cadinsor::Extensions::RequestError.new "Invalid Request. Client App is not valid." if !app
    end

    def cadinsor_validate_signature(params, signature, app_id_param,name, signature_param_name)
      raise Cadinsor::Extensions::RequestError.new "Invalid Request. Request signature is not present." if signature.to_s == ""
      request_string = ""
      params.keys.sort.each do |key|
        request_string = request_string + params[key] unless key == signature_param_name
      end
      request_string = request_string + Cadinsor::ClientApp.find_by_id(params[app_id_param_name]).secret
      request_hash = Digest::SHA2.hex_digest(request_string)
      raise Cadinsor::Extensions::RequestError.new "Invalid Request. Request Signature is not valid." if signature != request_hash
    end

  end
end