=begin
  spoken_filename_maker_test.rb 

  Tests for FilenameTextToSpeech class

  (c) 2017 Michoel Samuels
=end

require_relative 'text_to_speech_toolkit'

describe 'FilenameTextToSpeech' do 
  before do 
    @tts = TextToSpeechToolkit.new
  end
  
  it "should be defined" do
    assert defined? TextToSpeechToolkit
  end

  it "should be instantiable" do
    TextToSpeechToolkit.new
  end

  describe 'method :audio_file_from_string' do
    after do 
      test_file = 'spoken_filename.mp3'
      File.delete test_file if File.exists? test_file
    end

    it "should be defined" do
      assert_respond_to @tts, :audio_file_from_string
    end

    it "should require a single argument" do
      assert_raises (ArgumentError) { @tts.audio_file_from_string }
      @tts.audio_file_from_string 'bob' # implicit assert nothing raised
    end

    it "should return a String" do
      result = @tts.audio_file_from_string 'bob'
      assert_equal result.class, String
    end


    it "should call `new` on the Speech class, with the given string" do
      test_string = 'Marsch Dabruvski.mp3'
      
      mock_speech_object = Minitest::Mock.new
      mock_speech_object.expect :save, nil, ['spoken_filename.mp3']

      mock_speech_class = Minitest::Mock.new
      mock_speech_class.expect :new, mock_speech_object, [test_string] #<-- TEST HERE! 

      tts = TextToSpeechToolkit.new mock_speech_class
      tts.audio_file_from_string test_string 
      
      mock_speech_class.verify # verify that the mock's expectations have been satisfied
    end


    it "should call `:save` on the Speech object with a temp filename" do
      test_string = 'Marsch Dabruvski.mp3'
      
      mock_speech_object = Minitest::Mock.new
      mock_speech_object.expect :save, nil, ['spoken_filename.mp3'] # <----- TEST HERE!

      mock_speech_class = Minitest::Mock.new
      mock_speech_class.expect :new, mock_speech_object, [test_string] 

      tts = TextToSpeechToolkit.new mock_speech_class
      tts.audio_file_from_string test_string 

      mock_speech_object.verify
    end
  end
end



