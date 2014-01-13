module Cadinsor
  class ClientApp < ActiveRecord::Base
    validates_presence_of :name,:secret
    validates_uniqueness_of :name, :secret

    def generate_secret!
      self.secret = SecureRandom.urlsafe_base64(32)
      generate_secret! if App.find_by_secret(self.secret)
      self
    end

  end
end
