require 'spec_helper'

RSpec.describe TimemachineAPI::Thetime do 

  def app
    Rack::Builder.new do
      use LogMiddleWare
      run TimemachineAPI::Thetime
    end
  end

  before do
    log_mock = double('FakeLogger', info: true)
    LogMiddleWare.logger = log_mock
  end

  after do 
    puts MyLogger.padding
  end

  context "get clock" do
    it "returns 200" do
      get "/v1/clock/"
      expect(last_response.status).to eq 200
    end

    it "returns time" do
      get "/v1/clock/"
      body = JSON.parse(last_response.body)
      expect(body["actual_time"]).to eq Time.now.iso8601
    end
  end

  context "post unique clock" do
    it "returns 201" do
      post "/v1/clock/real_clock"
      expect(last_response.status).to eq 201
    end

    it "returns the body of the clock" do 
      get "/v1/clock/real_clock"
      body = JSON.parse(last_response.body)
      expect(body.nil?).to eq false
    end
  end

  context "get unique clock" do
    it "returns 200" do
      post "/v1/clock/real_clock"
      get "/v1/clock/real_clock"
      expect(last_response.status).to eq 200
    end

    it "returns 404" do
      post "/v1/clock/real_clock"
      get "/v1/clock/blah"
      expect(last_response.status).to eq 404
    end

    it "returns time" do
      post "/v1/clock/real_clock"
      get "/v1/clock/real_clock"
      body = JSON.parse(last_response.body)
      expect(body["actual_time"]).to eq Time.now.iso8601
    end

    it "returns attempts left" do
      post "/v1/clock/real_clock"
      get "/v1/clock/real_clock"
      body = JSON.parse(last_response.body)
      expect(body["attempts"]).to eq 0
    end
  end

  context "put already made clock" do
    it "updates time" do 
      post "/v1/clock/real_clock"
      put "/v1/clock/real_clock?actual_time=rubytest&attempts=6"
      get "/v1/clock/real_clock"
      body = JSON.parse(last_response.body)
      expect(body["actual_time"]).to eq "rubytest"
    end 

    it "does not update time" do 
      post "/v1/clock/real_clock"
      put "/v1/clock/real_clock?actual_time=rubytest&attempts=0"
      get "/v1/clock/real_clock"
      body = JSON.parse(last_response.body)
      expect(body["actual_time"]).to eq Time.now.iso8601
    end 

    it "decrements attempts" do
      post "/v1/clock/real_clock"
      put "/v1/clock/real_clock?actual_time=rubytest&attempts=6"
      get "/v1/clock/real_clock"
      body = JSON.parse(last_response.body)
      expect(body["attempts"]).to eq 5
    end

    context "Bad parameters" do
      it "returns 400 Invalid" do
        post "/v1/clock/real_clock"
        put "/v1/clock/real_clock?actual_time=rubytest&attempts=BadAttempts"
        expect(last_response.status).to eq 400
      end

      it "returns 400 Missing params" do
        post "/v1/clock/real_clock"
        put "/v1/clock/real_clock?"
        expect(last_response.status).to eq 400
      end
    end
  end

  context "put an unknown clock" do
    it "returns 400" do
      post "/v1/clock/real_clock"
      put "/v1/clock/blah?actual_time=50&attempts=5?"
      expect(last_response.status).to eq 400
    end
  end

  context "Delete unique clock" do 
    describe 'when the clock exists' do
      it "deletes clock" do 
        post "/v1/clock/real_clock"
        delete "/v1/clock/real_clock"
        expect(last_response.status).to eq 204
      end 
    end

    describe 'when the clock DOES NOT exists' do
      it "deletes unknown clock" do 
        post "/v1/clock/real_clock"
        delete "/v1/clock/3123123"
        expect(last_response.status).to eq 204
      end 
    end
  end
end

