=begin
  command_line_runner_test.rb 

  Tests for the CommandLineRunner class

  (c) 2017 Michoel Samuels
=end

require 'test_helper'

describe 'CommandLineRunner' do
  it "should be defined" do
    assert defined? CommandLineRunner
  end

  describe ':run method' do
    before do
      @joiner = CommandLineRunner.new
    end

    it "should be defined" do
      @joiner.send :run, ''
    end

    it "should run the given string on the system command line" do
      assert @joiner.send :run, 'echo'
      refute @joiner.send :run, 'blah'
    end
  end
end