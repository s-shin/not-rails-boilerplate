module App
  module Models
    class User < Base
      has_many :article
    end
  end
end
