=begin
  file_selector.rb 

  Declares the FileSelector class

  (c) 2017 Michoel Samuels
=end

class FileSelector
  attr_reader :directory

  def initialize path, dir_class = Dir
    @directory =  path
    @dir_class = dir_class
  end

  def select_mp3
    all_files = select_all_files
    all_files.select {|filename| filename =~ /.mp3/}
  end

  def select_all_files
    @dir_class.new(@directory).entries
  end

end