require 'addressable/uri'
require 'dotenv'
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'action_mailer'
require_relative 'app/models/user'
require_relative 'app/mailers/user_mailer'
require_relative 'app/mailers/application_mailer'
require 'pry'

Dotenv.load
set :views, Proc.new { File.join(root, "app/views") }

configure do
  enable :sessions
  set :session_secret, "secret"

  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.raise_delivery_errors = true
  ActionMailer::Base.view_paths = File.expand_path('../../tps/app/views/', __FILE__)
  ActionMailer::Base.smtp_settings = {
    address: 'smtp.sendgrid.net',
    authentication: :plain,
    domain: "example.com",
    enable_starttls_auto: true,
    password: ENV['SENDGRID_KEY'],
    port: 587,
    user_name: ENV['SENDGRID_USERNAME']
  }
end

VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
VERIFY_TOKEN_PATH = /.*\/(.*)\//

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
    if user.email_confirmed == true
      session[:user_id] = user.id
      redirect '/dashboard'
    else
      flash[:notice] = "Please confirm your email."
      redirect '/'
    end
  else
    flash[:notice] = "Login Failed."
    redirect '/'
  end
end

get '/reset' do
  erb :reset
end

post '/reset' do
  user = User.find_by(:email => params[:email])
  if user != nil
    user.set_reset_token
    user.save(validate: false)

    UserMailer.reset_password(request, user).deliver_now

    flash[:success] = "An email has been sent to reset your password."
    redirect '/'
  else
    flash[:notice] = "Password reset failed. " + user.errors.full_messsages.join(". ")
  end
end

get '/:token/password_reset' do
  erb :password_reset
end


post '/:token/password_reset' do
  password_reset
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
    flash[:notice] = "Registration successful."
    user.set_confirmation_token
    user.save(validate: false)

    UserMailer.registration_confirmation(request, user).deliver_now

    flash[:success] = "Please confirm your email address to continue"
    redirect '/'
  else
    flash[:notice] = "Registration failed. " + user.errors.full_messages.join(". ")
    redirect '/user/new'
  end
end

get '/:token/confirm_email/' do
  confirm_email
end

get '/user/:id/settings' do
  if !logged_in?
    redirect '/'
  else
    user = current_user
    erb :account_settings, :locals => { :user => user }
  end
end

get '/user/:id/settings/username/edit' do
  if !logged_in?
    redirect '/'
  else
    user = current_user
    erb :edit_username, :locals => { :user => user }
  end
end

def logged_in?
    !!session[:user_id]
end

def current_user
  User.find(session[:user_id])
end

def confirm_email
  user = User.find_by_confirm_token(params[:token])
  if user != nil
    user.validate_email
    user.save(validate: false)
    flash[:notice] = "Confirmed.  Please Sign In."
    redirect '/'
  else
    flash[:notice] = "Sorry. User does not exist"
    redirect '/'
  end
end

def password_reset
  user = User.find_by reset_token: params[:token]
  if user.update_attributes(
    :password => params[:password],
    :password_confirmation => params[:password_confirmation],
    :reset_token => nil
    )
    flash[:success] = "Your password has been updated.  You may now Sign In"
    redirect '/'
  else
    flash[:notice] = "Password reset failed. " + user.errors.full_messages.join(". ")
  end
end



