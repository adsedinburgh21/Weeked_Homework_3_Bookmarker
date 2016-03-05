require( 'sinatra')
require( 'sinatra/contrib/all' ) if development?
require( 'pg' )
require_relative( './models/bookmarker.rb' )


get '/bookmarker' do
  
end

get '/bookmarker/new' do
  @bookmarker = Bookmarker.new( params )
  erb(:new)
end

post '/bookmarker' do
  @bookmarker = Bookmarker.new( params )
  @bookmarker.save()
  erb(:create)
end

