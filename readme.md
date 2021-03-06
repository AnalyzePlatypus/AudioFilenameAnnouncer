# AudioFilenameAnnouncer
[![Build Status](https://travis-ci.org/AnalyzePlatypus/AudioFilenameAnnouncer.svg?branch=master)](https://travis-ci.org/AnalyzePlatypus/AudioFilenameAnnouncer)
[![Coverage Status](https://coveralls.io/repos/github/AnalyzePlatypus/AudioFilenameAnnouncer/badge.svg?branch=master)](https://coveralls.io/github/AnalyzePlatypus/AudioFilenameAnnouncer?branch=master)
[![Code Climate](https://codeclimate.com/github/AnalyzePlatypus/AudioFilenameAnnouncer/badges/gpa.svg)](https://codeclimate.com/github/AnalyzePlatypus/AudioFilenameAnnouncer)
[![Inline docs](http://inch-ci.org/github/AnalyzePlatypus/TranslitKit.svg?branch=master)](https://inch-ci.org/github/AnalyzePlatypus/AudioFilenameAnnouncer?branch=master)
[![license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/AnalyzePlatypus/AudioFilenameAnnouncer/blob/master/LICENSE.txt)

Remember the iPod Shuffle (RIP)? 
This script prepends audio files with a spoken announcement of their filename for hand-free use. Great for listening on digital recorders, primitive mp3 players, and displayless devices.

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

`brew install sox --with-lame`
`brew install espeak`

## Contributing

Currently maintained by [@AnalyzePlatypus](https://github.com/AnalyzePlatypus/).
Contributions are welcome!

See [ARCHITECTURE.md](https://github.com/AnalyzePlatypus/AudioFilenameAnnouncer/blob/master/architecture.md)
