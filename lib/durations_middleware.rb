require_relative 'my_logger'

class DurationsMiddleware
  def initialize(app)
    @app = app      
  end
  def call(env)
    MyLogger.method_location = "#{env['REQUEST_METHOD']} #{env['REQUEST_PATH']}"
    @start = Time.now
    @status, @headers, @body = @app.call(env)
    @duration = ((Time.now - @start).to_f * 1000).round(3)
    MyLogger.info "Took: #{@duration} ms"
    puts MyLogger.padding
    [@status, @headers, @body]
    
  end
end
