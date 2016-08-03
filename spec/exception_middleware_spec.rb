require 'spec_helper'

RSpec.describe TimemachineAPI::Thetime do 
  def app
    Rack::Builder.new do
      use ExceptionsMiddleware
      run TimemachineAPI::Thetime
    end
  end


  before do
    allow(Kernel).to receive(:puts).and_return(nil)
    allow(TimemachineAPI::Thetime).to receive(:call).and_raise("boom")
  end

  after do 
    MyLogger.padding 
  end

  context "testing exceptions" do 
    it "returns 500" do 
      get "/v1/clock/"
      expect(last_response.status).to eq 500
    end
  end 
end

