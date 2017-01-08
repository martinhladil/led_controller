#!/usr/bin/env ruby

require "rubygems"
require "bundler/setup"
Bundler.require(:default)
require_relative "led_controller/cli"

begin
  LedController::CLI.start(ARGV)
rescue LedController::InvalidFrame
  puts Paint["ERROR: Invalid Frame", :red]
end