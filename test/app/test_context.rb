module App
  class TestContext < Test::Unit::TestCase
    test 'env' do
      t = ENV['RACK_ENV']
      ENV['RACK_ENV'] = 'foobar'
      assert_equal 'foobar', Context.new.env
      ENV['RACK_ENV'] = t
    end

    test 'project_root' do
      assert((Pathname(Context.new.project_root) + 'lib').directory?)
    end

    test 'db' do
      assert Context.new.db_w.is_a? Sequel::Database
      assert Context.new.db_r.is_a? Sequel::Database
    end

    class Foo
      Context.new.inject self, :env
    end

    test 'inject' do
      foo = Foo.new
      assert_nothing_raised { foo.env }
      foo.env = 'foo'
      assert_equal 'foo', foo.env
    end
  end
end
