module App
  module API
    class Root < Grape::API
      Context.instance.inject self, :db_w, :db_r

      version 'v1', using: :path
      format :json
      prefix :api

      resource :messages do
        desc 'Get all messages.'
        get do
          DB::Mapper.use(db_r).select(Models::Message)
        end

        desc 'Post a message.'
        params do
          requires :name, type: String
          requires :title, type: String
          requires :body, type: String
        end
        post do
          msg = Models::Message.new(params)
          DB::Mapper.use(db_w).insert(msg)
        end
      end
    end
  end
end
