require File.join(File.expand_path(File.dirname(__FILE__)), '/../', 'server')

require 'sinatra'
require 'rack/test'
require 'capybara'
require 'database_cleaner'
require 'pry'
require_relative 'support/database_cleaner'
require_relative 'support/user_generation'

set :environment, :test

def app
  Sinatra::Application
end

ActiveRecord::Base.logger.level = 1

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

def computed_style(selector, prop)
  page.evaluate_script(
    "window.getComputedStyle(document.querySelector('#{selector}')).#{prop}"
  )
end
