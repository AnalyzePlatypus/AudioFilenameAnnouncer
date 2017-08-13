=begin
  file_selector_test.rb 

  Tests for the FileSelector class

  (c) 2017 Michoel Samuels
=end

require_relative 'file_selector'

describe "FileSelector" do

  before do
    @fake_path = 'billy/bob'
    @fake_filenames = %w(ok.mp3 bob.txt fred.pdf)
    
    dir_object =  Minitest::Mock.new
    dir_object.expect :entries, @fake_filenames
    
    @mock_dir_class = Minitest::Mock.new
    @mock_dir_class.expect :new, dir_object, [@fake_path]
    
    @file_selector = FileSelector.new @fake_path, @mock_dir_class
  end

  it "should be defined" do
    assert defined? FileSelector
  end

  describe 'args' do 
    it "should fail if initialized with no args" do
      assert_raises (ArgumentError) { FileSelector.new }
    end
  
    it "should not fail if initialized with a string" do
      FileSelector.new '/'
    end
  end
  
  it "should remember the given path" do
    directory_path = 'billy/bob'
    file_selector = FileSelector.new directory_path, @mock_dir_class
    assert_equal file_selector.directory, directory_path
  end

  describe 'file selection' do
    it "should have a method, :select_all_files" do
      assert_respond_to @file_selector, :select_all_files
    end

    it "should return the results of `Dir.new(path).entries`" do
      file_selector =  FileSelector.new @fake_path, @mock_dir_class
      assert_equal file_selector.select_all_files, @fake_filenames
    end
  end

  describe "mp3 selection" do
    it "should have a method `:select_mp3`" do
      assert_respond_to @file_selector, :select_mp3
    end

    it "should only return files ending in `.mp3`" do
      assert_equal @file_selector.select_mp3, @fake_filenames.select {|f| f.include? '.mp3'}
    end
  end
end