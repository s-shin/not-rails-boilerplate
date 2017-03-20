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
  end
end
