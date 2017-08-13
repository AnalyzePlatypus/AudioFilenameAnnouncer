# FileSpeak

`FileSpeak` is a Ruby script that prepends the spoken filename to a mp3 file.

## Usage

```ruby
file_path = 'path/to/file.mp3'

FileSpeak.process file_path
#=> Processing file `file.mp3`
# [1/2] Generating spoken title
# [2/2] Prepending to original file
# Done!
```

```ruby
directory = 'path/to/files'

FileSpeak.process directory
#=> Processing directory `path/to/files`
# 14 mp3 files found (2 rejected)
# [1/14] file_1.mp3 ... done
# [2/14] file_2.mp3 ... done
# ...etc.
```

## Architecture

`FileSpeak` exposes the `FileSpeak` class.

Internal classes:

* `FileSelector` selects the relevant (`=~ '.mp3'`) files in a directory.

* `SpokenFilenamePrepender` Wraps the whole process.

* `TextToSpeechToolkit` creates the spoken filename audio file.

* `FileJoiner` can merge audio files

