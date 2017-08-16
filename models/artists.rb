require_relative("../sql_runner.rb")

class Artist

  attr_accessor :name
  attr_reader :id

  def initialize( params )
    @id = params["id"].to_i() if params["id"]
    @name = params["name"]
  end

  def Artist.all()
    sql = "SELECT * FROM artists"
    results = SqlRunner.run(sql)
    artists = results.map{ |artist_hash| Artist.new(artist_hash) }
  return artists
  end

  def save()
    sql = "
      INSERT INTO artists
        (name)
      VALUES
        ($1)
      RETURNING *;
    "
    returned_data = SqlRunner.run(sql, [@name])
    @id = returned_data[0]['id'].to_i()
  end

  def Artist.delete_all
    sql = "DELETE FROM artists;"
    SqlRunner.run(sql)
  end

  def albums
    sql = "
      SELECT * FROM albums
      WHERE artist_id = $1;
    "
    album_hashes = SqlRunner.run(sql, [@id])

    artist_albums = album_hashes.map { |album_hash| Album.new(album_hash) }

    return artist_albums
  end

  def update()
    sql = "
      UPDATE artists SET(
        name
      ) = (
        $1
      )
      WHERE id = $2;
    "
    SqlRunner.run(sql, [@name, @id])
  end

  def Artist.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    results = SqlRunner.run(sql, [@id])
    artist_hash = results[0]
    artist = Artist.new(artist_hash)
    return artist
  end
  
end
