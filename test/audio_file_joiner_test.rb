=begin
  audio_file_joiner_test.rb 

  Tests for the AudioFileJoiner class

  (c) 2017 Michoel Samuels
=end

require 'test_helper'

describe 'AudioFileJoiner' do
  it "should be defined" do
    assert defined? AudioFileJoiner
  end

  # -------------------

  describe ':prepend_to_file method' do 
    before do
      @joiner = AudioFileJoiner.new
    end

    it "should be defined" do
      assert_respond_to @joiner, :prepend_to_file
    end

    it "should require 2 args" do
      assert_raises (ArgumentError) { @joiner.prepend_to_file }
      assert_raises (ArgumentError) { @joiner.prepend_to_file '' }
      @joiner.prepend_to_file '', ''
    end
  end

  # -------------------

  describe '`assert_file_exists` method' do
    before do
      @fake_file_class = Minitest::Mock.new
    end

    it "should exist" do
      joiner = AudioFileJoiner.new 
      joiner.send :file_exists?, ''
    end

    it "should detect if the file exists" do
      real_file_path = 'path/to/real'
      @fake_file_class.expect :exist?, true, [real_file_path]
      
      fake_file_path = 'path/to/fake'
      @fake_file_class.expect :exist?, false, [fake_file_path]
      
      joiner = AudioFileJoiner.new @fake_file_class
      
      assert joiner.send :file_exists?, real_file_path
      refute joiner.send :file_exists?, fake_file_path
      @fake_file_class.verify
    end
  end

  # -------------------

  describe ':create_sox_concat_command method' do 
    before do
      @joiner = AudioFileJoiner.new
    end

    it "should be defined" do
      @joiner.send :create_sox_concat_command, '', '', ''
    end

    it "should create a string with format `sox arg1 arg2 arg3`" do
      args = %w(larry curly moe)
      expected_string = "sox #{args[0]} #{args[1]} #{args[2]}"
      generated_string = @joiner.send :create_sox_concat_command, args[0], args[1], args[2]
      assert_equal expected_string, generated_string
    end
  end

  # -------------------

  describe ":concat method" do

    before do
      @joiner = AudioFileJoiner.new
    end

    it "should be defined" do
      assert @joiner.respond_to? :concat
    end

    it "should require all args to contain a file extension (.)" do
      assert_raises (ArgumentError) {@joiner.concat 'noext', 'no_extension', 'none here'}
    end

    it "should generate and pass the correct command string to the command line" do
      @fake_command_line_class = Minitest::Mock.new
      @fake_command_line_instance = Minitest::Mock.new
      @fake_command_line_class.expect :new, @fake_command_line_instance
      
      @fake_file_system = Minitest::Mock.new
      
      # Create a new joiner with mock objects
      @joiner = AudioFileJoiner.new @fake_file_system, @fake_command_line_class

      files = %w(file1.mp3 file2.mp3)
      output_filename = "output.mp3"

      # Bypass file exists check
      @fake_file_system.expect :exist?, true, [files[0]]
      @fake_file_system.expect :exist?, true, [files[1]]
      
      @fake_command_line_instance.expect :run, true, ["sox #{files[0]} #{files[1]} #{output_filename}"]
      
      @joiner.concat files[0], files[1], output_filename

      @fake_command_line_instance.verify
    end
  end
end