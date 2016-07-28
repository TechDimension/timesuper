require_relative '../lib/clock'

RSpec.describe Clock do 
	context ".actualtime" do 
		it "Correct date will be shown" do
			Clock.actual_time=5
			expect(Clock.actual_time).to eq 5
		end
	end 

	context ".actualtime" do 
		it "shows real time when attempts = 0" do 
			Clock.attempts = 0 
			Clock.decrement_attempts
			expect(Clock.actual_time).to eq Time.now.iso8601
		end
	end

	context ".attempts" do
		it "gives the correct number of attempts left" do
			Clock.attempts = 5
			expect(Clock.attempts).to eq 5
		end 
	end 

	context ".decrement_attempts" do 
		it "decrement_attempts by 1" do
			Clock.attempts = 5 
			Clock.decrement_attempts
			expect(Clock.attempts).to eq 4
		end
	end 
end
