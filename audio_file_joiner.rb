=begin
  audio_file_joiner.rb 

  Declares the AudioFileJoiner class

  (c) 2017 Michoel Samuels
=end

class AudioFileJoiner
  def initialize file_class = File
    @file_system = file_class
  end

  def prepend_to_file file, file_to_prepend
  end

  def concat file1, file2, output_filename 
    assert_file_exists file1
    assert_file_exists file2
    #system "sox #{file1} #{file2} #{output_filename}"
  end

  private 

  def assert_file_exists file_path 
    unless file_exists? file_path 
      raise ArgumentError.new "Could find file `#{file_path}`: No such file or directory" 
    end
  end

  def file_exists? file_path
    @file_system.exist? file_path
  end

  
end