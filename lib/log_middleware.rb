require_relative 'my_logger'

class LogMiddleWare
  def initialize(app)
    @app = app      
  end

  def call(env)
    @app.call(env)
  end

  def self.logger
    @logger ||= Logger
  end

  def self.logger= value
    @logger = value
  end
end

