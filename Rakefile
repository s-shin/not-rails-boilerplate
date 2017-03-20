require_relative './boot'

desc 'Run test_unit based test'
Rake::TestTask.new do |t|
  # To run test for only one file (or file path pattern)
  #  $ bundle exec rake test TEST=test/test_specified_path.rb
  t.libs << 'test'
  t.test_files = Dir['test/**/test_*.rb']
  t.ruby_opts << '-r./boot' << '-r./test/boot'
  t.verbose = true
  t.warning = false
end

desc 'Run console.'
task :console do
  pry
end

namespace :schema do
  common_command = %W(
    ridgepole
    -c config/database.yml
    -E #{ENV['RACK_ENV']}_w
    --enable-mysql-awesome
  )

  task :export do
    cmd = common_command + ['-o db/Schemafile -e']
    sh(cmd.join(' '))
  end

  task :check do
    cmd = common_command + %w(-f db/Schemafile -a --dry-run)
    sh(cmd.join(' '))
  end

  task :apply do
    cmd = common_command + %w(-f db/Schemafile -a)
    sh(cmd.join(' '))
  end
end

Dir.glob('lib/tasks/*.rake') { |file| load file }
