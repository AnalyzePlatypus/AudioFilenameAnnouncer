=begin
  test_runner.rb 

  Runs Minitest test suite

  (c) 2017 Michoel Samuels
=end

require "minitest/autorun"
require 'minitest/color'
require 'fakefs/safe'

require_relative 'file_selector_test'
require_relative 'text_to_speech_toolkit_test'
require_relative 'audio_file_joiner_test'