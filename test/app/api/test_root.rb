module App
  module API
    class TestRoot < Test::Unit::TestCase
      include Rack::Test::Methods
      include FactoryGirl::Syntax::Methods

      def app
        Root
      end

      App::Context.instance.inject self, :db_w

      setup do
        db_w.run("TRUNCATE messages")
        @message = create(:message)
      end

      test 'GET /messages' do
        pp @message
      end

      test 'POST /messages' do
      end
    end
  end
end
