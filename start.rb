#!/usr/bin/env ruby
require 'puma/cli'
require 'yaml'
config = YAML.load_file("config/configuration.yml")

Puma::CLI.new(['-p', config["server"]["port"].to_s]).run

