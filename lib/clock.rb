class Clock
  class << self
    attr_accessor :actual_time , :attempts

    def decrement_attempts
      if attempts>0
        @attempts = attempts - 1
      else
        self.actual_time = get_time
      end
    end

    private 

    def get_time
      Time.new.iso8601
    end
  end
end