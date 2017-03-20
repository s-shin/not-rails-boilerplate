require_relative './boot'

use App::Context::RackMiddleware, App::Context.instance

run App::API::Root.new
