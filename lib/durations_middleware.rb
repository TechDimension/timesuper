
class DurationsMiddleware
  def initialize(app)
    @app = app      
  end
  def call(env)
    @start = Time.now
    @status, @headers, @body = @app.call(env)
    @duration = ((Time.now - @start).to_f * 1000).round(3)

    puts "#{env['REQUEST_METHOD']} #{env['REQUEST_PATH']} - Took: #{@duration} ms"
    [@status, @headers, @body]
  end
end
