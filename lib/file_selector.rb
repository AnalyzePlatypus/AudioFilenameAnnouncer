=begin
  file_selector.rb 

  Declares the FileSelector class

  (c) 2017 Michoel Samuels
=end

class FileSelector
  attr_reader :directory

  AUDIO_FILE_REGEX = /.mp3/

  # Create a new FileSelector object. 
  # Takes a path to a directory to select files from.
  # The `Dir` class can be injected for testing
  def initialize path, dir_class = Dir
    @directory =  path
    @dir_class = dir_class
  end

  # Select all files from the directory that match `AUDIO_FILE_REGEX`
  def select_mp3
    all_files = select_all_files
    all_files.select {|filename| filename =~ AUDIO_FILE_REGEX}
  end

  # Select all files from the directory
  # (uses Dir.entries)
  def select_all_files
    @dir_class.new(@directory).entries
  end

end
