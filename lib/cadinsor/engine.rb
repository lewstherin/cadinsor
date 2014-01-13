module Cadinsor
  class Engine < ::Rails::Engine
    isolate_namespace Cadinsor
    # Set key expiry time in minutes
    self.config.key_expiry_time_in_mins = 5
    self.config.client_app_id_param_name = :client_app_id
    self.config.api_key_param_name = :api_key
    self.config.request_signature_param_name = :signature
  end
end
