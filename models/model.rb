require 'lyricfy'
require 'rspotify'
require 'pp'

RSpotify.authenticate("dc6d67e381b840d5972fa0c2ce423f70", "a48ab1d312204495a468a2601542ec02")


# turn spotify user/playlist_id into playlist

# turns songs into lyrics
# fetcher = Lyricfy::Fetcher.new
# song = fetcher.search 'Coldplay', 'Viva la vida'
# puts song.body # prints lyrics separated by '\n'

# def get_lyrics(song,artist)
#     fetcher = Lyricfy::Fetcher.new
#     lyrics = fetcher.search(artist,song)
#     lyrics.body.split('\n') # array of lyrics
# end

# puts get_lyrics('Youth','Daughter')

class Song
    attr_reader :name, :artist, :album_img, :lyrics
    
    def initialize(name,artist,album_img)
        @name = name
        @artist = artist
        @album_img = album_img
    end
    
    def get_lyrics
        begin
            fetcher = Lyricfy::Fetcher.new
            lyrics = fetcher.search(@artist,@name)
            @lyrics = lyrics.body.split('\n') # array of lyrics
        rescue
            @lyrics = ["Sorry, no lyrics found."]
        end
    end
end

# youth = Song.new("Youth","Daughter","http://")
# youth.get_lyrics
# puts youth.lyrics

# spotify client ID
# dc6d67e381b840d5972fa0c2ce423f70
# spotify client secret
# a48ab1d312204495a468a2601542ec02

# playlist = RSpotify::Playlist.find('guilhermesad', '1Xi8mgiuHHPLQYOw2Q16xv')
# pp playlist.tracks.first
# puts playlist.tracks.first.name
# puts playlist.tracks.first.artists.first.name
# puts playlist.tracks.first.album.images.first["url"]

class Playlist
    
    attr_reader :user, :playlist_id, :name, :songs
    
    def initialize(user,playlist_id)
        @user = user
        @playlist_id = playlist_id
        @songs = [] # instances of the Song class
    end
    
    def get_info
        playlist = RSpotify::Playlist.find(@user,@playlist_id)
        @name = playlist.name
        
        playlist.tracks.each do |track|
            @songs << Song.new(track.name,track.artists.first.name,track.album.images.first["url"])
        end
    end
    
    def get_all_lyrics
       @songs.each do |song|
           song.get_lyrics
       end
    end
end

# girl3 = Playlist.new("1114072956","7zGjKWLsPf7yyOm7d5hGR9")
# girl3.get_info
# puts girl3.name
    