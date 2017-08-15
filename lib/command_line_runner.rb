=begin
  command_line_runner.rb 

  Declares the CommandLineRunner class

  (c) 2017 Michoel Samuels
=end

# Runs 
class CommandLineRunner
  
  # Runs `command` on the command line
  def CommandLineRunner.run command
    system command
  end
  
end