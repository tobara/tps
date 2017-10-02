require "sinatra"
require "sinatra/activerecord"
require 'pry'
require 'sinatra/flash'
enable :sessions
require_relative 'app/models/user'
set :views, Proc.new { File.join(root, "app/views") }

get '/' do
  erb :sign_in
end

post '/session/new' do
end

get '/user/new' do
  erb :new_user
end

post '/user/new' do
  user = User.new(
    :username => params[:username],
    :email => params[:email],
    :first_name => params[:first_name],
    :last_name => params[:last_name],
    :password => params[:password],
    :password_confirmation => params[:password_confirmation]
  )

  if user.save
    session[:user_id] = user.id
    flash[:notice] = "Registration successful.  Please Sign In."
    redirect '/'
  else
    flash[:notice] = "Registration failed. " + user.errors.full_messages.join(". ")
    redirect '/user/new'
  end
end



