# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative 'AudioFilenameAnnouncer/version'

Gem::Specification.new do |spec|
  spec.name          = "AudioFilenameAnnouncer"
  spec.version       = AudioFilenameAnnouncer::VERSION
  spec.authors       = ["Michoel Samuels"]
  spec.email         = ["k2co3@icloud.com"]

  spec.summary       = %q{Prepend audio files with a spoken announcement of the filename}
  spec.description   = %q{Remember the iPod Shuffle (RIP)? This script prepends audio files with a spoken announcement of their filename for hand-free use. Great for listening on digital recorders, primitive mp3 players, and displayless devices}
  spec.homepage      = "https://github.com/AnalyzePlatypus/AudioFilenameAnnouncer"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "espeak-ruby", "~> 1.0.4"
  
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency 'minitest-color'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'coveralls'
end
