require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models'
require 'dotenv/load'

require 'net/http'
require 'uri'

enable :sessions

before do
   Dotenv.load
   Cloudinary.config do |config|
       config.cloud_name = ENV['CLOUD_NAME']
       config.api_key    = ENV['CLOUDINARY_API_KEY']
       config.api_secret = ENV['CLOUDINARY_API_SECRET']
   end
end

helpers do
    def current_user
        User.find_by(id: session[:user])
    end
end

get '/' do
    @posts = Post.all
    erb :index
end

get '/home' do
    erb :home
end

get '/search' do
    uri = URI("https://itunes.apple.com/search?")
    uri.query = URI.encode_www_form({
        term: params["keyword"],
        media: "music",
        country: "JP",
        limit: 30
    })
    res = Net::HTTP.get_response(uri)
    json = JSON.parse(res.body)
    @music_results = json["results"]
    erb :search
end

get '/signup' do
    erb :sign_up
end

post '/signin' do
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
        session[:user] = user.id
    end
    redirect '/'
end

post '/signup' do
    img_url = ''
    if params[:file]
      img = params[:file]
      tempfile = img[:tempfile]
      upload = Cloudinary::Uploader.upload(tempfile.path)
      img_url = upload['url']
    end
    
    @user = User.create({
        name: params[:name], 
        password: params[:password],
        password_confirmation: params[:password_confirmation],
        user_img: img_url
    })
    if @user.persisted?
        session[:user] = @user.id
    end
    redirect '/'
end

post '/post' do
    current_user.posts.create(
        music_img: params[:img],
        artist_name: params[:artist],
        album_name: params[:album],
        music_name: params[:music],
        music_sample: params[:sample],
        comment: params[:comment]
        )
    redirect '/home'
end

get '/post/:id/favorite' do
    Favorite.create(
            post_id: params[:id],
            user_id: current_user.id
        )
    redirect '/home'
end

get '/post/:id/delete_favorite' do
    favorite = current_user.favorites.find_by(post_id: current_user.id)
    favorite.delete
    redirect '/'
end


get '/signout' do
    session[:user] = nil
    redirect '/'
end