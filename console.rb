require("pry")
require_relative("models/artists.rb")
require_relative("models/albums.rb")

Album.delete_all
Artist.delete_all()


artist1 = Artist.new({"name" => "The National"})
artist2 = Artist.new({"name" => "Imagine Dragoons"})
artist1.save()
artist2.save()

album1 = Album.new({
  "artist_id" => artist1.id,
  "title" => "High Violet",
  "genre" => "indie rock"
})
album1.save()

album2 = Album.new({
  "artist_id" => artist2.id,
  "title" => "Day Visions",
  "genre" => "indie/alt rock"
})
album2.save()

artist2.name = "Imagine Dragons"
artist2.update

album2.title = "Night Visions"
album2.update

binding.pry
nil
