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

  def self.find( id )
    database = PG.connect( { dbname: 'bookmarker', host: 'localhost'} )
    sql = "SELECT * FROM bookmarks WHERE id = #{id}"
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

  def self.destroy( input )
    database = PG.connect( { dbname: 'bookmarker', host: 'localhost'} )
    sql = "DELETE FROM bookmarks WHERE id = #{input}"
    result = database.exec( sql )
    database.close
    return result
  end

  def self.genre(genre)
    database = PG.connect( {dbname: 'bookmarker', host: 'localhost'} )
    sql = "SELECT * FROM bookmarks WHERE genre = '#{genre}'"
    search_result = database.exec( sql )
    result = search_result.map { |bookmark| Bookmarker.new(bookmark) }
    database.close
    return result
  end

  def self.search(search)
    database = PG.connect( {dbname: 'bookmarker', host: 'localhost'} )
    sql = "SELECT * FROM bookmarks WHERE name LIKE '%#{search}%'"
    search_result = database.exec( sql )
    result = search_result.map { |bookmark| Bookmarker.new(bookmark) }
    database.close
    return result
  end

end
#### This is how I planned to search by genre but I'm not sure how to link this to a page on the browser. I would call Bookmarker.genre( input_from_dropdown_of_all_genres ). So I would like to create a page 'select by genre' on which there will be a drop down list of all the genres and when you pick one the screen will display all bookmarks in the database with that selected genre. I thought maybe I could use the index.erb page to display the info but I dont know?


#### Also I am aware that I can refactor above using the code below. I just prefered to write out the long version just now as I think it will help me to learn the process more thoroughly.

  # private   

  # def self.run_sql( sql )
  #   begin
  #     database = PG.connect( { dbname: 'bookmarker', host: 'localhost'} )
  #     result = database.exec( sql )
  #     return result
  #   ensure
  #     database.close
  #   end
  # end
