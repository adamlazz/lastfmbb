Gem::Specification.new do |s|
    s.name        = 'lastfmbb'
    s.version     = '0.1.0'
    s.executables << 'lastfmbb'
    s.date        = '2014-05-01'
    s.summary     = "lastfmbb"
    s.description = "lastfmbb is a Ruby gem that uses the Last.fm API to generate BBCode for pasting into your About Me section based on your top artists, albums or tracks."
    s.authors     = ["Adam Lazzarato"]
    s.email       = 'adam.lazzarato@gmail.com'
    s.files       = ["bin/lastfmbb",
        "lib/lastfmbb.rb",
        "lib/lastfmbb/album.rb",
        "lib/lastfmbb/artist.rb",
        "lib/lastfmbb/request.rb",
        "lib/lastfmbb/track.rb"]
    s.homepage    = 'https://www.github.com/adamlazz/lastfmbb'
    s.license     = 'MIT'
end
