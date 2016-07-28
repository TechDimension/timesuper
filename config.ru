require_relative 'lib/timemachine'
require_relative 'lib/log_middleware'

app = Rack::Builder.new do
  use LogMiddleWare
  run Timemachine::Thetime
  # run lambda {|env| [200, {},["OK"]]}
end

run app