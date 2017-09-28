require "sinatra"
require "sinatra/activerecord"


set :views, Proc.new { File.join(root, "app/views") }

get "/" do
  erb :index
end

