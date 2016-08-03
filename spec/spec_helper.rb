require "rack/test"
require_relative "../lib/exceptions_middleware"
require_relative "../lib/time_api/api"
require_relative "../lib/log_middleware"
require_relative "../lib/my_logger"

RSpec.configure do |c|
  c.include Rack::Test::Methods
end