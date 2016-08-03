require 'spec_helper'

RSpec.describe MyLogger do 
  context "produces log message for an event" do
    before do
      allow(Kernel).to receive(:puts).and_return(nil)
      allow(Config).to receive(:logger_config).and_return("location" => 'a.log', 'level' => 'debug')
      @output = []
      allow(File).to receive(:open) do |loc, opts, &block|
        block.call(@output)
      end
    end

    after do 
      MyLogger.padding 
    end

    it "MyLogger.info" do
      MyLogger.info('message')
      expect(@output[0]).to match(/\[Unknown\] \[INFO\]:  message/)
    end

    it "MyLogger.debug" do
      MyLogger.debug('message')
      expect(@output[0]).to match(/\[Unknown\] \[DEBUG\]: message/)
    end

    it "MyLogger.error" do
      MyLogger.error('message')
      expect(@output[0]).to match(/\[Unknown\] \[ERROR\]: message/)
    end
  end
end