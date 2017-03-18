module DB
  class TestMapper < Test::Unit::TestCase
    class User < DB::Model
      self.column_names = [:id, :name]
    end

    class Friend < DB::Model
      self.column_names = [:id, :user_id, :friend_user_id]
    end

    class << self
      def db
        @db ||= Sequel.sqlite
      end

      def startup
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

      def shutdown
        @db.disconnect
        @db = nil
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
