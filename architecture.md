# Architecture

**`AudioFilenameAnnouncer`** exposes the public `AudioFilenameAnnouncer` class.
This is the only class users iteract with.

The actual work is performed by several entirely independent classes the closely follow the [Single Responsibility Principle](https://en.wikipedia.org/wiki/Single_responsibility_principle).


Internal classes:

* `TextToSpeechToolkit` can create spoken audio files from strings.

* `FileJoiner` can merge audio files

* `FileSelector` can select relevant (matching `/.mp3/`) files from a directory.