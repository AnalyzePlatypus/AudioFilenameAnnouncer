=begin
  audio_file_joiner_test.rb 

  Tests for the AudioFileJoiner class

  (c) 2017 Michoel Samuels
=end

require_relative 'audio_file_joiner'

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

  describe ':concat method' do 
    before do
      @joiner = AudioFileJoiner.new
    end

    it "should be defined" do
      assert_respond_to @joiner, :concat
    end

    it "should require 3 args" do
      # Cruft to mock out the file system so we don't have to pass actual files to `#concat`
      @fake_file_class = Minitest::Mock.new
      FILE_EXIST_WILL_BE_CALLED_COUNT = 6
      FILE_EXIST_WILL_BE_CALLED_COUNT.times do 
        # Allow File#exist? to be called `FILE_EXIST_WILL_BE_CALLED_COUNT` times
        @fake_file_class.expect :exist?, true, ['']  
      end
      joiner = AudioFileJoiner.new @fake_file_class

      # Actual tests
      assert_raises (ArgumentError) {joiner.concat}
      assert_raises (ArgumentError) {joiner.concat ''}
      assert_raises (ArgumentError) {joiner.concat '', ''}
      joiner.concat '', '', ''
    end

    it "should require all args to contain a file extension (.)" do
      assert_raises (ArgumentError) {@joiner.concat 'noext', 'no_extension', 'none here'}
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

  describe ':run method' do
    before do
      @joiner = AudioFileJoiner.new
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