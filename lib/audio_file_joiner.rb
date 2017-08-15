=begin
  audio_file_joiner.rb 

  Declares the AudioFileJoiner class

  Methods:
    * :prepend_to_file file, prefix_file
    * :concat file_1, file_2, output_path

  (c) 2017 Michoel Samuels
=end

require 'command_line_runner'

# Concatenates audio files
class AudioFileJoiner

  # Create a new AudioFileJoiner.
  # Allows injecting alternate File and CommandLineRunner classes for testing
  def initialize file_class = File, command_line_runner = CommandLineRunner, file_utils = FileUtils
    @file_system = file_class 
    @command_line_runner = command_line_runner
    @file_utils = file_utils 
  end

  # Prepend `prefix_file` to `file`.
  # `file` is destructively altered.
  def prepend_to_file main_file, prefix_file
    assert_files_exist [main_file, prefix_file]
    
    output_dir = determine_directory main_file
    
    output_file = "#{output_dir}/tmp_output.mp3"
    
    run sox_concat_command prefix_file, main_file, output_file
    overwrite_file main_file, output_file
  end

  # Concatenate `file1` and `file2`, and write the output to `output_filename`
  def concat file1, file2, output_filename 
    assert_files_exist [file1, file2]
    command = sox_concat_command  file1, file2, output_filename 
    run command
  end

  private

  # Does each entry in `files` exist?
  # Raises an exception
  def assert_files_exist files
    files.each {|f| assert_file_exists f}
  end

  # Raise an exception if `file` cannot be found
  def assert_file_exists file 
    unless file_exists? file 
      raise ArgumentError.new "Could not find file `#{file}`: No such file or directory" 
    end
  end

  # Does `file` exist?
  def file_exists? file
    @file_system.exist? file
  end

  # Creates the `sox` concat commands to be run on the command line
  def sox_concat_command  file1, file2, output_filename 
    "sox #{file1} #{file2} #{output_filename}"
  end

  # Run `command` on the command line
  def run command
    @command_line_runner.run command
  end

  def determine_directory path
    @file_system.dirname path
  end

  def overwrite_file old_file, new_file
    @file_utils.mv new_file, old_file
  end
end