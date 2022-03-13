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


get '/signout' do
    session[:user] = nil
    redirect '/'
end