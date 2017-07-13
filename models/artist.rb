require 'pry-byebug'
require_relative '../db/sql_runner'

class Artist

  attr_reader :id
  attr_writer :name

  def initialize(options)
    # id is not passed to def as an argument when creating new object in the 
    # console. So id is initially set to 0. When a new object is created
    # from a row of the table artists id is set to be the index of that row.
    @id = options['id'].to_i 
    @name = options['name']
  end

  def save
    sql = "INSERT INTO artists (name) VALUES ('#{@name}') RETURNING id;"
    # The SqlRunner object returns the results of the sql command in an 
    # 'array' of hashes, with each hash corresponding to a table row. IN 
    # this case an 'array' with a single hash (corresponding to the artist)
    # is returned. The rest of this command looks at the first/ only hash in # this returned array ([0]) gets the value of the key 'id' (a string 
    # corresponding to the table row index) and converts it to an integer 
    # before setting it to instance variable @id.
    @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM artists;"
    artists = SqlRunner.run(sql)
    artists.map { |artist| Artist.new(artist) }
  end

  def all_albums_of_artist
    sql = "SELECT * FROM albums WHERE artist_id = #{@id};"
    albums = SqlRunner.run(sql)
    albums.map { |album| Album.new(album) }
  end

  def update
    sql = "UPDATE artists SET (name) = ('#{@name}') WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM artists where id = #{@id}"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = #{id}"
    SqlRunner.run(sql)
  end

end