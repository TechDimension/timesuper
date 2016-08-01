require 'spec_helper'
require_relative "../lib/timemachine"
require_relative "../lib/log_middleware"

RSpec.describe Timemachine::Thetime do 
  def app
    Rack::Builder.new do
     use LogMiddleWare
     run Timemachine::Thetime
    end
  end

  before do
    log_mock = double('FakeLogger', info: true)
    LogMiddleWare.logger = log_mock
  end



  context "post unique clock" do
    it "returns created status code" do
      post "/v1/clock/real_clock?"
      expect(last_response.status).to eq 201
    end
  end

  context "get unique clock" do
    it "returns 200" do
      get "/v1/clock/real_clock"
      expect(last_response.status).to eq 200
    end

    it "returns 404" do
      get "/v1/clock/blah"
      expect(last_response.status).to eq 404
    end

    it "returns time" do
      get "/v1/clock/real_clock"
      body = JSON.parse(last_response.body)
      expect(body["time"]).to eq Time.now.iso8601
    end

    it "returns attempts left" do
      get "/v1/clock/real_clock"
      body = JSON.parse(last_response.body)
      expect(body["attempts_left"]).to eq 0
    end

    it "decrements attempts" do
      put "/v1/clock/real_clock?actual_time=rubytest&attempts=6"
      get "/v1/clock/real_clock"
      body = JSON.parse(last_response.body)
      expect(body["attempts_left"]).to eq 5
    end
  end

  context "put unique clock" do
    it "updates time" do 
      post "/v1/clock/real_clock?actual_time=rubytest&attempts=6"
      get "/v1/clock"
      body = JSON.parse(last_response.body)
      expect(body["time"]).to eq "rubytest"
    end 

    it "returns 400" do
      put "/v1/clock/real_clock2?actual_time=50&attempts=5?"
      expect(last_response.status).to eq 400
    end
  end

    


end

