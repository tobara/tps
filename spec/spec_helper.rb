require File.join(File.expand_path(File.dirname(__FILE__)), '/../', 'server')

require 'sinatra'
require 'rack/test'
require 'capybara'
require 'database_cleaner'

set :environment, :test

#specify that the app is a Sinatra app
def app
  Sinatra::Application
end

#make Rack::Text available to all spec contexts
RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
