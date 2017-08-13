=begin
  text_to_speech_toolkit.rb 

  Declares the TextToSpeechToolkit class

  (c) 2017 Michoel Samuels
=end

require 'espeak'

include ESpeak


# Creates an audio file for 
class TextToSpeechToolkit
  TEMP_FILENAME = 'spoken_filename.mp3'

  # Create a new `TextToSpeechToolkit` object. Allows injecting the speech class for testing
  def initialize speech_class = Speech
    @speech_class = speech_class
  end

  # Create an audio file
  def audio_file_from_string string
    make_speech_object(string).save TEMP_FILENAME
    TEMP_FILENAME
  end

  private 

  # Create a new instance of @speech_class, passing in `string``
  def make_speech_object string 
    @speech_class.new string
  end
  
end

