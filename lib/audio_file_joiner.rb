=begin
  audio_file_joiner.rb 

  Declares the AudioFileJoiner class

  (c) 2017 Michoel Samuels
=end

require 'command_line_runner'

class AudioFileJoiner
  def initialize file_class = File, command_line_runner = CommandLineRunner
    @file_system = file_class
    @command_line_runner = command_line_runner.new 
  end

  def prepend_to_file file, prefix_file
    assert_files_exist [file, prefix_file]
    command = sox_concat_command prefix_file, file, file
    run command
  end

  def concat file1, file2, output_filename 
    assert_files_exist [file1, file2]
    command = sox_concat_command  file1, file2, output_filename 
    run command
  end

  private 

  def assert_files_exist files
    files.each {|f| assert_file_exists f}
  end

  def assert_file_exists file_path 
    unless file_exists? file_path 
      raise ArgumentError.new "Could find file `#{file_path}`: No such file or directory" 
    end
  end

  def file_exists? file_path
    @file_system.exist? file_path
  end

  def sox_concat_command  file1, file2, output_filename 
    "sox #{file1} #{file2} #{output_filename}"
  end

  def run command
    @command_line_runner.run command
  end
end