require 'spec_helper'
require_relative "../lib/exceptions_middleware"
require_relative "../lib/log_middleware"

RSpec.describe ExceptionsMiddleware do 
  def app
    Rack::Builder.new do
     use LogMiddleWare
     use ExceptionsMiddleware
    end
  end

  before do
    log_mock = double('FakeLogger', info: true)
    LogMiddleWare.logger = log_mock
  end

  context "testing exceptions" do 
    it "raises error with Name Error" do 
      expect {object.somemethod("what")}.to raise_error(NameError)
      expect {HELLO}.to raise_error(NameError)
    end
    it "raises error with Type Error" do 
      expect {[2,4].first["two"]}.to raise_error(TypeError)
    end
    it "raises error with Zero Division Error" do 
      expect {99/0}.to raise_error(ZeroDivisionError)
    end
  end 
end

