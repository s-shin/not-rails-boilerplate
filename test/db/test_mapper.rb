module DB
  class TestMapper < Test::Unit::TestCase
    class Base < Hashie::Dash
      extend DB::Table
      def self.column_names
        properties
      end
    end

    class User < Base
      property :id
      property :name
    end

    class Friend < Base
      property :id
      property :user_id
      property :friend_user_id
    end

    class << self
      def db
        App::Context.instance.db_w
      end

      def startup
        db.run('DROP TABLE IF EXISTS users, friends')
        db.create_table :users do
          primary_key :id
          String :name
        end
        db.create_table :friends do
          primary_key :id
          Integer :user_id
          Integer :friend_user_id
        end
        foo_id = db[:users].insert(name: 'foo')
        bar_id = db[:users].insert(name: 'bar')
        fizz_id = db[:users].insert(name: 'fizz')
        db[:friends].insert(user_id: foo_id, friend_user_id: bar_id)
        db[:friends].insert(user_id: foo_id, friend_user_id: fizz_id)
      end
    end

    def db
      self.class.db
    end

    test 'Select friend users from an user.' do
      mapper = DB::Mapper.use(db)
      user = mapper.select(User).where(name: 'foo').first
      assert_equal 1, user.id
      friends = mapper.select(Friend).where(user_id: user.id).all
      assert_equal [1, 2], friends.map(&:id)
      friend_users = mapper.select(User).where(id: friends.map(&:friend_user_id)).all
      assert_equal [2, 3], friend_users.map(&:id)
    end
  end
end
