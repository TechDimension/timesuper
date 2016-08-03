require_relative 'my_logger'
class Clock
  attr_writer :attempts
  attr_writer :actual_time

  def initialize
    self.attempts = attempts
    self.actual_time = actual_time
  end

  def attempts
    @attempts||=0
  end

  def actual_time
    @actual_time||=Time.now.iso8601
  end

  def decrement_attempts
    MyLogger.debug "decrementing attempts"
    if attempts > 0
      MyLogger.info "decremented attempts"
      @attempts -= 1
    else
      MyLogger.info "Did not decrement attempts"
      self.actual_time = Time.now.iso8601
    end
  end

  def to_json_format
    {actual_time: actual_time, attempts: attempts}
  end
end