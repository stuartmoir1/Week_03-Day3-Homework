require 'pry-byebug'
require_relative './models/artist'
require_relative './models/album'

# Save artists to DB.
artist1 = Artist.new( {'name' => 'Phoenix'} )
artist1.save
artist2 = Artist.new( {'name' => 'The Avalanches'} )
artist2.save

# Save albums to DB.
album1 = Album.new ( {
  'title' => 'Bankrupt',
  'genre' => 'Alternative Rock',
  'artist_id' => artist1.id
})
album2 = Album.new ( {
  'title' => 'Ti Amo',
  'genre' => 'Disco Rock',
  'artist_id' => artist1.id
})
album3 = Album.new ( {
  'title' => 'Wildflower',
  'genre' => 'Plunderphonics',
  'artist_id' => artist2.id
})
album1.save
album2.save
album3.save

# All artists.
artists = Artist.all
# All albums.
albums = Album.all

# All albums of artist.
albums_of_artist1 = artist1.all_albums_of_artist
albums_of_artist2 = artist2.all_albums_of_artist
# Artist of album.
album1_artist = album1.artist_of_album
album2_artist = album2.artist_of_album
album3_artist = album3.artist_of_album

# Update artist.
artist1.name = 'Patrick Watson'
artist1.update

# Update albums.
album1.title = 'Love Songs for Robots'
album1.genre = 'Experimental'
album1.update
album2.title = 'Adventures In Your Own Backyard'
album2.genre = 'Indie'
album2.update

# Delete album.
album1.delete
albums_album1_deleted = Album.all

# Find album.
found_album = Album.find(3)

# Delete all albums.
albums_left = Album.delete_all

# Delete artist.
artist1.delete
artists_artist1_deleted = Artist.all

# Find album.
found_artist = Artist.find(2)

# Delete all albums.
artists_left = Artist.delete_all

binding.pry
nil