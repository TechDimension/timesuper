
class LogMiddleWare
  def initialize(app)
    @app = app      
  end

  def call(env)
    self.class.logger.info 'Calling the app'
    @app.call(env)
  end

  def self.logger
    @logger ||= Logger
  end

  def self.logger= value
    @logger = value
  end
end

class Logger
  def self.info(message)
    puts message
  end
end