require_relative 'lib/time_api/api'
require_relative 'lib/log_middleware'
require_relative 'lib/durations_middleware'
require_relative 'lib/exceptions_middleware'

app = Rack::Builder.new do
  use LogMiddleWare
  use ExceptionsMiddleware
  use DurationsMiddleware
  run TimemachineAPI::Thetime
end

run app