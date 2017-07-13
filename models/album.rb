require 'pry-byebug'
require_relative '../db/sql_runner'

class Album

  attr_writer :title, :genre

  def initialize(options)
    # In the following line, the if statement is not needed. If 'id' is not
    # defined in the object is set to 0, which is correct for when the
    # object is defined to put data in the table.
    @id = options['id'].to_i # if options['id'] 
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

  def save
    sql = "INSERT INTO albums (title, genre, artist_id) VALUES ('#{@title}', '#{@genre}', #{@artist_id}) RETURNING id;"
    @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM albums;"
    albums = SqlRunner.run(sql)
    albums.map { |album| Album.new(album) }
  end

  def artist_of_album
    sql = "SELECT * FROM artists WHERE id = #{@artist_id};"
    artist = SqlRunner.run(sql)[0]
    Artist.new(artist) 
  end

  def update
    sql = "UPDATE albums SET (title, genre, artist_id) = ('#{@title}', '#{@genre}', '#{@artist_id}') WHERE id = #{@artist_id};"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM albums where id = #{@id}"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM albums WHERE id = #{id}"
    SqlRunner.run(sql)
  end

end