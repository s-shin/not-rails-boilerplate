require_relative './boot'

use App::Context::RackMiddleware

run App::API::Root.new
