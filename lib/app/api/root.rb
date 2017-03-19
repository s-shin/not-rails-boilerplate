module App
  module API
    class Root < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api

      resource :messages do
        desc 'Create a message.'
        params do
          # TODO
        end
        post do
          # TODO
        end
      end
    end
  end
end
