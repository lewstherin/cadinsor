module Cadinsor
  class ApiKey < ActiveRecord::Base
    belongs_to :client_app
    validates_presence_of :key

    def generate_key!
      self.key = SecureRandom.urlsafe_base64(32)
      generate_key! if Cadinsor::ApiKey.find_by_key(self.key)
      # Return object for chaining requests
      self
    end

    def expired?
      return true if self.created_at < Cadinsor::Engine.config.key_expiry_time_in_mins.to_i.minutes.ago
      false
    end

  end
end
