require( 'sinatra')
require( 'sinatra/contrib/all' ) if development?
require( 'pg' )
require_relative( './models/bookmarker.rb' )


get '/bookmarker' do
  @bookmarker = Bookmarker.all
  erb(:index)
end

get '/bookmarker/new' do
  erb(:new)
end

get '/bookmarker/:id' do
  @bookmarker = Bookmarker.find( params[:id] )
  erb(:show)
end

post '/bookmarker' do
  @bookmarker = Bookmarker.new( params )
  @bookmarker.save()
  erb(:create)
end

get '/bookmarker/:id/edit' do
  @bookmarker = Bookmarker.find( params[:id] )
  erb( :edit )
end

post '/bookmarker/:id' do
  Bookmarker.update( params )
  redirect(to( "bookmarker/#{params[:id]}" ))
end

post '/bookmarker/:id/delete' do
  Bookmarker.destroy( params[:id] )
  redirect(to( '/bookmarker'))
end
##### Why can I not type this url straight in to the browser to delete entries?

