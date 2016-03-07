require( 'sinatra')
require( 'sinatra/contrib/all' ) if development?
require( 'pg' )
require_relative( './models/bookmarker.rb' )


get '/bookmarker' do
  if params[:search]
    @bookmarker = Bookmarker.search( params[:search] )
  elsif params[:select_genre]
    @bookmarker = Bookmarker.genre( params[:select_genre] )
  else
    @bookmarker = Bookmarker.all
  end
    erb(:index)
end
##### The if above is in place for the search function. If the search 


get '/bookmarker/new' do
  erb(:new)
end

# get "/bookmarker/genre" do
#   erb(:genre)
# end
# #### I thought the above get & below post requests might allow me to search by Genre - but it errors.  (and i dont think they are restful).
# post "/bookmarker/genre" do
#   @bookmarker = Bookmarker.genre(params[:search])
#   erb(:index)
# end

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
  erb( :delete )
end
##### Why can I not type this url straight in to the browser to delete entries?




