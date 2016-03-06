require( 'minitest/autorun' )
require( 'minitest/rg' )
require_relative( '../models/bookmarker.rb' )

class TestBookmarker < MiniTest::Test

  def setup

    test= {
      'id' => 1,
      'name' => 'BBC',
      'url' => 'http://www.bbc.co.uk/',
      'genre' => 'news'
    }

    @bookmarker = Bookmarker.new( test )
  end


  def test_name
    assert_equal( 'BBC', @bookmarker.name)
  end

  def test_url
    assert_equal( 'http://www.bbc.co.uk/', @bookmarker.url)
  end

  def test_id
    assert_equal( 1, @bookmarker.id)
  end

  def test_genre
    assert_equal( 'news', @bookmarker.genre)
  end









end