require_relative 'my_logger'

class ExceptionsMiddleware
  def initialize(app)
    @app = app      
  end

  def call(env)
    @app.call(env)
  rescue StandardError => e
    MyLogger.error('Standard Error!')
    [ 500, { }, [ "Standard Error!" ]]
  end
end
