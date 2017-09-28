require "sinatra"
require "sinatra/activerecord"


set :views, Proc.new { File.join(root, "app/views") }

get "/" do
  erb :sign_in
end

post "/sign_in" do

end

get "/new_user" do
  erb :new_user
end

post "/user/new" do

end

