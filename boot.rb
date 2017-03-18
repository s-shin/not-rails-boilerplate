warn 'WARNING: RACK_ENV should be specified.' unless ENV['RACK_ENV']

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('./Gemfile', __dir__)
require 'bundler/setup' if File.exist?(ENV['BUNDLE_GEMFILE'])
Bundler.require(*[:default, ENV['RACK_ENV']].compact)

require 'active_support'
require 'active_support/core_ext'
ActiveSupport::Dependencies.autoload_paths << File.expand_path('./lib', __dir__)

PROJECT_ROOT = __dir__
