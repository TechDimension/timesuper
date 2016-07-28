
class LogMiddleWare
  def initialize(app)
    @app = app      
  end

  def call(env)
    puts 'Calling the app'
  
    @app.call(env)

  end

end
