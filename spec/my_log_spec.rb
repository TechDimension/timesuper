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

  context "produces log message for an event" do
    it "MyLogger.info" do
      MyLogger.info ('message')
      file = File.open('log/application_log.txt').to_a
      expect("#{file.last}").to eq "[#{Time.now}] [Unknown] [INFO]:  message \n"
    end
    it "MyLogger.debug" do
      MyLogger.debug ('message')
      file = File.open('log/application_log.txt').to_a
      expect("#{file.last}").to eq "[#{Time.now}] [Unknown] [DEBUG]: message \n"
    end
    it "MyLogger.error" do
      MyLogger.error ('message')
      file = File.open('log/application_log.txt').to_a
      expect("#{file.last}").to eq "[#{Time.now}] [Unknown] [ERROR]: message \n"
    end
  end
end