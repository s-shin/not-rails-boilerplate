module App
  module API
    class Root < Grape::API
      Context.instance.inject self, :db_w, :db_r

      version 'v1', using: :path
      format :json
      prefix :api

      resource :messages do
        desc 'Create a message.'
        get do
          DB::Mapper.use(db_r).select(Models::Message)
        end
      end

      resource :messages do
        desc 'Create a message.'
        params do
          # TODO
        end
        post do
          msg = Models::Message.new(params)
          DB::Mapper.use(db_w).insert(msg)
        end
      end
    end
  end
end
