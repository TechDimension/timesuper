class ClocksManager
  class << self

    def create_clock(name) 
      clocks_hash.merge!(name => Clock.new)
    end

    def clocks_hash
      @clocks_hash ||= {}
    end
   
    def delete_clock(name)
      clocks_hash.delete(name)
    end

    def update_clock(name:, attempts:, actual_time:)
      clocks_hash[name].attempts = attempts
      clocks_hash[name].actual_time = actual_time
    end

    def show_clock(name)
      clock = clocks_hash[name]
      if clock != nil
        clock.decrement_attempts
        clock.to_json_format
      else
        nil
      end
    end

  end
end






