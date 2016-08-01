require_relative '../lib/clock'

RSpec.describe Clock do 

  context ".new" do 
    it "intializes new clock instance with default values" do 
      clock = Clock.new
      expect(clock).to be_a Clock
    end 
  end 

  context ".actualtime" do 
    it "shows real time" do 
      clock = Clock.new
      expect(clock.actual_time).to eq Time.now.iso8601
    end

    it "modifies time" do 
      clock = Clock.new
      clock.actual_time = "testtime"
      expect(clock.actual_time).to eq "testtime"
    end
  end
  
  context ".attempts" do 
    it "shows attempts" do
      clock = Clock.new
      expect(clock.attempts).to eq 0
    end

    it "updates attempts" do
      clock = Clock.new
      clock.attempts = 5 
      expect(clock.attempts).to eq 5
    end
  end 

  context ".decrement_attempts" do 
    it "decrement_attempts by 1" do
      clock = Clock.new
      clock.attempts = 5 
      clock.decrement_attempts
      expect(clock.attempts).to eq 4
    end

    it "keeps attempts >= 0" do
      clock = Clock.new
      clock.attempts = 1 
      clock.decrement_attempts
      clock.decrement_attempts
      clock.decrement_attempts
      expect(clock.attempts).to eq 0
    end
  end 
  context ".to_json_format" do
    it "converts format of instance to json" do 
      clock = Clock.new
      expect(clock.to_json_format).to be_a Hash
    end
  end

end
