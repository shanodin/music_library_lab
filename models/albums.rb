require_relative("../sql_runner.rb")

class Album

  attr_accessor :title, :genre
  attr_reader :artist_id

  def initialize( album_details )
    @artist_id = album_details["artist_id"]
    @title = album_details["title"]
    @genre = album_details["genre"]
  end

  def save()
    sql = "
      INSERT INTO albums
        (artist_id, title, genre)
      VALUES
        ($1, $2, $3)
      RETURNING *;
    "
    returned_data = SqlRunner.run(sql, [@artist_id, @title, @genre])
    @id = returned_data[0]['id'].to_i()
  end

  def Album.delete_all()
    sql = "DELETE FROM albums;"
    SqlRunner.run(sql)
  end

  def artist()
    sql = "
      SELECT * FROM artists
      WHERE id = $1;
    "
    results_array = SqlRunner.run(sql, [@artist_id])

    artist_hash = results_array[0]
    artist_object = Artist.new(artist_hash)

    return artist_object
  end



end
