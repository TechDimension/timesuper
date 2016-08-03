require 'yaml'


class MyLogger
  class << self
    attr_writer :method_location

    def info(message)
      if level >=  error_level_mapper['info']
        File.open(location, 'a') { |file| file << ("[#{Time.now}] [#{method_location}] [INFO]:  #{message} \n")}
        puts "[#{Time.now}] [#{method_location}] [INFO]:  #{message} \n"
      end
    end

    def error(message)
      if level >= error_level_mapper['error']
        File.open(location, 'a') { |file| file << ("[#{Time.now}] [#{method_location}] [ERROR]: #{message} \n")}
        puts "[#{Time.now}] [#{method_location}] [ERROR]:  #{message} \n"
      end
    end

    def debug(message)
      if level >= error_level_mapper['debug']
        File.open(location, 'a') { |file| file << ("[#{Time.now}] [#{method_location}] [DEBUG]: #{message} \n")}
        puts "[#{Time.now}] [#{method_location}] [DEBUG]: #{message} \n"
      end
    end

    def padding
      File.open(location, 'a') { |file| file << ("========================================================================================================== \n")}
       " ========================================================================================================== \n"
    end

    def method_location
      @method_location ||= "Unknown"
    end

    private

    def level
      error_level_mapper[Config.logger_config["level"]]
    end

    def location
      Config.logger_config["location"]
    end

    def error_level_mapper
      {
        'error' => 0,
        'info'  => 1,
        'debug' => 2
      }
    end
  end
end

class Config
  def self.logger_config
    config = YAML.load_file("config/configuration.yml")
    config["logger"]
  end
end

