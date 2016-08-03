
class ClocksCollection
  class << self

    def create_clock(name) 
      clocks_hash.merge!(name => Clock.new)
      MyLogger.info ("Created clock with name: #{name}")
    end
   
    def delete_clock(name)
      clocks_hash.delete(name)
      MyLogger.info ("Deleted Clock with name: #{name}")
    end

    def update_clock(name:, attempts:, actual_time:)
      clocks_hash[name].attempts = attempts
      clocks_hash[name].actual_time = actual_time
      MyLogger.info ("Updated Clock with name: #{name}")
    end

    def show_clock(name)
      clock = clocks_hash[name]
      if clock != nil
        MyLogger.info ("Clock Found with name: #{name}")
        clock.decrement_attempts
        clock.to_json_format
      else
        MyLogger.info ("No Clock Found with name: #{name}")
        nil
      end
    end

    private 

    def clocks_hash
      @clocks_hash ||= {}
    end
  end
end






