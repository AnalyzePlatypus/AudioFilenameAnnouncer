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
  # Allows injecting classes for testing
  def initialize file_class = File, command_line_runner = CommandLineRunner, file_utils = FileUtils
    @file_system = file_class 
    @command_line_runner = command_line_runner
    @file_utils = file_utils 
  end

  # Prefix `main_file` with `prefix_file`.
  # `main_file` is destructively altered.
  def prepend_to_file main_file, prefix_file
    output_dir = determine_directory main_file
    output_file = "#{output_dir}/tmp_output.mp3"

    concat prefix_file, main_file, output_file
    overwrite_file main_file, output_file
  end

  # Concatenate `file1` and `file2`, and write the output to `output_filename`
  def concat file1, file2, output_filename 
    command = sox_concat_command file1, file2, output_filename 
    run command
  end

  private

  # Creates the `sox` concat commands to be run on the command line
  def sox_concat_command  file1, file2, output_filename 
    "sox #{file1} #{file2} #{output_filename}"
  end

  # Run `command` on the command line
  def run command
    @command_line_runner.run command
  end

  # Determine the enclosing directory of the end of `path`
  def determine_directory path
    @file_system.dirname path
  end

  # Replace the contents of `old_file` with `new_file` (filename is not altered)
  def overwrite_file old_file, new_file
    @file_utils.mv new_file, old_file
  end
end
