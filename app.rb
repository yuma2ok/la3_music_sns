require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models'
require 'dotenv/load'

enable :sessions

get '/' do
    erb :index
end

get '/home' do
    erb :home
end

get '/search' do
    erb :search
end

get '/signup' do
    erb :sign_up
end

post '/signup' do
    @user = User.create(mail:params[:mail], password:params[:password],
    password_confirmation:params[:password_confirmation], file:params[:file])
    if @user.persisted?
        session[:user] = @user.id
    end
    redirect '/'
end


get '/signout' do
    session[:user] = nil
    redirect '/'
end