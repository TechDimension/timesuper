class Clock
  attr_writer :attempts
  attr_writer :actual_time

  def initialize()
    self.attempts = attempts
    self.actual_time = actual_time
  end

  def attempts
    @attempts||=0
  end

  def actual_time
    @actual_time ||= Time.now.iso8601
  end

  def decrement_attempts
    if attempts > 0
      @attempts -= 1
    else
      self.actual_time = Time.now.iso8601
    end
  end

  def to_json
    {actual_time: actual_time, attempts: attempts}
  end
end