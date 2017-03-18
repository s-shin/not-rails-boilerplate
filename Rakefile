require_relative './boot'

desc 'Run test_unit based test'
Rake::TestTask.new do |t|
  # To run test for only one file (or file path pattern)
  #  $ bundle exec rake test TEST=test/test_specified_path.rb
  t.libs << 'test'
  t.test_files = Dir['test/**/test_*.rb']
  t.ruby_opts << '-r./boot'
  t.verbose = true
  t.warning = false
end

desc 'Run console.'
task :console do
  ENV['RACK_ENV'] ||= 'development'
  pry
end

Dir.glob('lib/tasks/*.rake') { |file| load file }
