Gem::Specification.new do |s|
    s.name        = 'lastfmbb'
    s.version     = '0.0.0'
    s.executables << 'lastfmbb'
    s.date        = '2014-05-01'
    s.summary     = "lastfmbb"
    s.description = "bb-last.rb is a Ruby gem that uses the Last.fm API to generate BBCode for pasting into your About Me section based on your top artists, albums or tracks."
    s.authors     = ["Adam Lazzarato"]
    s.email       = 'adam.lazzarato@gmail.com'
    s.files       = ["bin/lastfmbb",
        "lib/lastfmbb.rb",
        "lib/lastfmbb/album.rb",
        "lib/lastfmbb/artist.rb",
        "lib/lastfmbb/request.rb",
        "lib/lastfmbb/track.rb",
        "Rakefile"]
    s.test_files = ["test/test_lastfmbb.rb"]
    s.homepage    = 'http://rubygems.org/gems/lastfmbb'
    s.license     = 'MIT'
end