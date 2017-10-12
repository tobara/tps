require File.join(File.expand_path(File.dirname(__FILE__)), '/../', 'server')

require 'sinatra'
require 'rack/test'
require 'capybara'
require 'database_cleaner'
require 'pry'

set :environment, :test

#specify that the app is a Sinatra app
def app
  Sinatra::Application
end

def create_user
  user = User.create(
      :username => 'pescobar',
      :email => 'pablo.escobar@gmail.com',
      :first_name => 'Pablo',
      :last_name => 'Escobar',
      :password => 'PabloKnowsAll100!',
      :password_confirmation => 'PabloKnowsAll100!'
  )
end


#make Rack::Text available to all spec contexts
RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
