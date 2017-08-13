=begin
  spoken_filename_maker.rb 


tts = TextToSpeechToolkit.new

filename = file
spoken_filename_audio_file = speech.say_as_audio_file filename

join_files spoken_filename_audio_file, orig


  Declares the FilenameTextToSpeech class
=end

require 'espeak'

include ESpeak


# Creates an audio file for 
class TextToSpeechToolkit
  TEMP_FILENAME = 'spoken_filename.mp3'

  def initialize speech_class = Speech
    @speech_class = speech_class
  end

  def audio_file_from_string string
    speech_object = make_speech_object(string).save TEMP_FILENAME
    TEMP_FILENAME
  end

  private 

  def make_speech_object string 
    @speech_class.new string
  end
  
end

