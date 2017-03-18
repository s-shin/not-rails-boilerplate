module App
  module Models
    class Article < Base
      property :id
      property :user_id
      property :title
      property :body
    end
  end
end
