=begin
  command_line_runner.rb 

  Declares the CommandLineRunner class

  (c) 2017 Michoel Samuels
=end

# Runs 
class CommandLineRunner
  # Run `command` on the command line
  def run command
    system command
  end
end