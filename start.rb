#!/usr/bin/env ruby
require 'puma/cli'
Puma::CLI.new(['-p', "7337"]).run