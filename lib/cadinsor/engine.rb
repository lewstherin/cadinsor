module Cadinsor
  class Engine < ::Rails::Engine
    isolate_namespace Cadinsor
    # Set key expiry time in minutes
    self.config.key_expiry_time_in_mins = 5

  end
end
