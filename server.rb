require "sinatra"
require "sinatra/activerecord"
require 'sinatra/flash'
require 'action_mailer'
require_relative 'app/models/user'
require_relative 'app/mailers/user_mailer'
require_relative 'app/mailers/application_mailer'
set :views, Proc.new { File.join(root, "app/views") }


configure do
  enable :sessions
  set :session_secret, "secret"
  ActionMailer::Base.raise_delivery_errors = true
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
   :address => 'smtp.sendgrid.net',
   :port           => 587,
   :domain         => "example.com",
   :authentication => :plain,
   :user_name => "apikey",
   :password => "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",
   :enable_starttls_auto => true
  }
  ActionMailer::Base.view_paths = File.expand_path('../../../app/views/', __FILE__)
end


VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

get '/' do
  if !logged_in?
    erb :landing
  else
    redirect to '/dashboard'
  end
end

get '/dashboard' do
  erb :dashboard
end

get '/sign-in' do
  erb :sign_in
end

post '/session/new' do
  if VALID_EMAIL_REGEX.match(params[:username])
    user = User.find_by(:email => params[:username])
  else
    user = User.find_by(:username => params[:username])
  end

  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect '/dashboard'
  else
    flash[:notice] = "Login Failed."
    redirect '/'
  end
end

get '/reset' do
  erb :reset_password
end

get '/logout' do
  session.destroy if session[:user_id]
  redirect '/'
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
    flash[:notice] = "Registration successful."
    redirect '/'
  else
    flash[:notice] = "Registration failed. " + user.errors.full_messages.join(". ")
    redirect '/user/new'
  end
end


def logged_in?
    !!session[:user_id]
end

def current_user
  User.find(session[:user_id])
end



