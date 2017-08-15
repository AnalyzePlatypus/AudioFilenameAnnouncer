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

  describe ':sox_concat_command method' do 
    before do
      @joiner = AudioFileJoiner.new
    end

    it "should be defined" do
      @joiner.send :sox_concat_command, '', '', ''
    end

    it "should create a string with format `sox arg1 arg2 arg3`" do
      args = %w(larry curly moe)
      expected_string = "sox #{args[0]} #{args[1]} #{args[2]}"
      generated_string = @joiner.send :sox_concat_command, args[0], args[1], args[2]
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
      @fake_command_line = Minitest::Mock.new
      
      @fake_file_system = Minitest::Mock.new
      
      # Create a new joiner with mock objects
      @joiner = AudioFileJoiner.new @fake_file_system, @fake_command_line

      files = %w(file1.mp3 file2.mp3)
      output_filename = "output.mp3"

      # Bypass file exists check
      @fake_file_system.expect :exist?, true, [files[0]]
      @fake_file_system.expect :exist?, true, [files[1]]
      
      # THE ACTUAL TEST

      @fake_command_line.expect :run, true, ["sox #{files[0]} #{files[1]} #{output_filename}"]
      
      @joiner.concat files[0], files[1], output_filename

      @fake_command_line.verify
    end
  end

  #------------------

  describe ":prepend_to_file method" do
    before do
      @joiner = AudioFileJoiner.new
    end

    it "should be defined" do
      assert_respond_to @joiner, :prepend_to_file
    end

    it "should generate the correct sox command" do
      
      @fake_file_system = Minitest::Mock.new
      @fake_file_utils = Minitest::Mock.new
      @fake_command_line = Minitest::Mock.new

      # Create a new joiner with mock objects
      @joiner = AudioFileJoiner.new @fake_file_system, @fake_command_line, @fake_file_utils

      main_file = 'fred/main.mp3'
      prefix_file = 'fred/prefix.mp3'
      output_file = 'fred/tmp_output.mp3'

      # Bypass file exists check
      @fake_file_system.expect :exist?, true, [main_file]
      @fake_file_system.expect :exist?, true, [prefix_file]
      @fake_file_system.expect :dirname, File.dirname(main_file), [main_file]
      @fake_file_utils.expect :mv, true, [output_file, main_file]

      # THE ACTUAL TEST

      @fake_command_line.expect :run, true, ["sox #{prefix_file} #{main_file} #{output_file}"]
      @joiner.prepend_to_file main_file, prefix_file
      @fake_command_line.verify
    end

    it "should tell FileUtils to overwrite the main input file with the newly generated file" do
      @fake_file_system = Minitest::Mock.new
      @fake_command_line = Minitest::Mock.new
      @fake_file_utils = Minitest::Mock.new
      
      # Create a new joiner with mock objects
      @joiner = AudioFileJoiner.new @fake_file_system, @fake_command_line, @fake_file_utils

      main_file = 'fred/main.mp3'
      prefix_file = 'fred/prefix.mp3'
      output_file = 'fred/tmp_output.mp3'

      # Bypass file exists check
      @fake_file_system.expect :exist?, true, [main_file]
      @fake_file_system.expect :exist?, true, [prefix_file]
      @fake_file_system.expect :dirname, File.dirname(main_file), [main_file]
      @fake_command_line.expect :run, true, ["sox #{prefix_file} #{main_file} #{output_file}"]
      
      # THE TEST
      @fake_file_utils.expect :mv, true, [output_file, main_file]

      @joiner.prepend_to_file main_file, prefix_file
      @fake_file_utils.verify
    end
  end  

  describe ":determine_directory method" do
    before do
      @joiner = AudioFileJoiner.new
    end
    
    it "should be defined" do
      assert @joiner.respond_to? :determine_directory, true
    end

    it "should return the path minus the last item" do
      path = 'path/to/bob'
      result = @joiner.send :determine_directory, path
      assert_equal 'path/to', result
    end

    it "should call the underlying File object" do
      path = 'billy/bob'
      
      fake_fs = Minitest::Mock.
        new.
        expect :dirname, 'billy', [path]

      AudioFileJoiner.
        new(fake_fs).
        send :determine_directory, path

      fake_fs.verify
    end
  end

  describe ":overwrite_file method" do
    before do
      @joiner = AudioFileJoiner.new
    end

    it "should be defined" do
      assert @joiner.respond_to? :overwrite_file, true
    end

    it "should FileUtils#mv to do the heavy lifting" do
      new_file = 'new_file'
      old_file = 'old_file'
      
      fake_fs_utils = Minitest::Mock.new.
        expect :mv, nil, [new_file, old_file]

        AudioFileJoiner.
          new(nil, nil, fake_fs_utils).
          send :overwrite_file, old_file, new_file
      
      fake_fs_utils.verify
    end
  end

  describe ":rename_file"
end