# AudioFilenameAnnouncer

`AudioFilenameAnnouncer` is a Ruby script that prepends the spoken filename to a mp3 file.

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

## Architecture

See ARCHITECTURE.md