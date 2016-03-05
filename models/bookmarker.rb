require( 'pg' )

class Bookmarker

  attr_reader :name, :url, :id, :genre

  def initialize(options)
    @id = nil || options['id']
    @name = options['name']
    @url = options['url']
    @genre = options['genre']  
  end

  def save
    database = PG.connect( { dbname: 'bookmarker', host: 'localhost'} )
    sql = "INSERT INTO bookmarks (
      name,
      url,
      genre) VALUES (
      '#{@name}',
      '#{@url}',
      '#{@genre}'
      );"
      database.exec( sql )
      database.close
  end



end