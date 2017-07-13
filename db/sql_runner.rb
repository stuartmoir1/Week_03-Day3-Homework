require 'pg'

class SqlRunner

  def self.run(sql)
    begin
      db = PG.connect( { dbname: 'collection', host: 'localhost' } )
      result = db.exec(sql)
    ensure
      db.close
    end
    result
  end

end