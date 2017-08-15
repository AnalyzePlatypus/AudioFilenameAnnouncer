# AudioFilenameAnnouncer

UNDER DEVELOPMENT - ALPHA

Remember the iPod Shuffle (RIP)?

`AudioFilenameAnnouncer` is a Ruby script that reads the filename aloud at the start of an mp3 file.


## Usage

```ruby
file_path = 'path/to/file.mp3'

AudioFilenameAnnouncer.process file_path
#=> Processing file `file.mp3`
# [1/2] Generating spoken title
# [2/2] Prepending to original file
# Done!
```

```ruby
directory = 'path/to/files'

AudioFilenameAnnouncer.process directory
#=> Processing directory `path/to/files`
# 14 mp3 files found (2 rejected)
# [1/14] file_1.mp3 ... done
# [2/14] file_2.mp3 ... done
# ...etc.
```
## Credits

Speech synthesis provided by [espeak-ruby](https://github.com/dejan/espeak-ruby).

Audio processing and mp3 encoding provided by [sox](http://sox.sourceforge.net) and [LAME](http://lame.sourceforge.net)

## Requirements

`brew install lame sox espeak`

## Contributing

Currently maintained by [@AnalyzePlatypus](https://github.com/AnalyzePlatypus/).
Contributions are welcome!

See [ARCHITECTURE.md](https://github.com/AnalyzePlatypus/AudioFilenameAnnouncer/blob/master/architecture.md)
