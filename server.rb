require "sinatra"
require "sinatra/activerecord"
require 'pry'
set :views, Proc.new { File.join(root, "app/views") }

get "/" do
  erb :sign_in
end

post "/session/new" do
end

get "/user/new" do
  erb :new_user
end

post "/user/new" do
  if params["password"]

  user = User.new(
    :username => params["username"],
    :email => params["email"],
    :first_name => params["first_name"],
    :last_name => params["last_name"],
    :password => params["password"]
  )
end
