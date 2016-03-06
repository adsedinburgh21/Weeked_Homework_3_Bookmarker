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

  def self.all
    database = PG.connect( { dbname: 'bookmarker', host: 'localhost'} )
    sql = "SELECT * FROM bookmarks"
    all_bookmarks = database.exec( sql )
    result = all_bookmarks.map { |bookmark| Bookmarker.new(bookmark) }
    database.close
    return result
  end

  def self.find(data)
    database = PG.connect( { dbname: 'bookmarker', host: 'localhost'} )
    sql = "SELECT * FROM bookmarks WHERE id = #{data}"
    bookmark = database.exec( sql )
    result = Bookmarker.new( bookmark[0] )
    database.close
    return result
  end

  def self.update( options )
    database = PG.connect( { dbname: 'bookmarker', host: 'localhost'} )
    sql = "UPDATE bookmarks SET
      name = '#{options['name']}',
      url = '#{options['url']}',
      genre = '#{options['genre']}'
      WHERE id = '#{options['id']}'"
    database.exec( sql )
    database.close
  end

end