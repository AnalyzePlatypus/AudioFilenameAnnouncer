=begin
  test_runner.rb 

  Runs Minitest test suite

  (c) 2017 Michoel Samuels
=end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

# Coverage reporter
require 'simplecov'
SimpleCov.start

# Enable Coveralls test coverage tester
require 'coveralls'
# Coveralls.wear!

require "minitest/autorun"
require 'minitest/color'

require 'audio_file_joiner'
require 'file_selector'
require 'text_to_speech_toolkit'
require 'command_line_runner'

