#!/usr/bin/env ruby
require 'puma/cli'
Puma::CLI.new(['-p', "3000"]).run