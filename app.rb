require 'sinatra/base'
require 'sinatra/reloader'

class BookmarkManager < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    'Bookmark Manager'
  end

  get '/bookmarks' do
    @bookmarks = [
      'https://www.google.com', 
      'https://www.amazon.co.uk',
    ]
    erb :'bookmarks/index'
  end

  run! if app_file == $0

end
