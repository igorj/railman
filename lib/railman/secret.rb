require 'securerandom'

module Railman
  module Secret
    def self.generate_secret
      SecureRandom.hex(64)
    end
  end
end