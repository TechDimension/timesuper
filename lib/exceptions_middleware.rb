class ExceptionsMiddleware
  def initialize(app)
    @app = app      
  end
  def call(env)
    @app.call(env)
  rescue StandardError => e
  end
end
