require 'spec_helper'
require 'test/unit'
require 'rack/test'
require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {js_errors: false})
end

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

user = User.create(
      :username => 'pescobar11',
      :email => 'pablo11.escobar@gmail.com',
      :first_name => 'Pabloa',
      :last_name => 'Escobara',
      :password => 'PabloKnowsAll100!',
      :password_confirmation => 'PabloKnowsAll100!'
  )

feature 'user can login and register', %{
  As a potential user
  I want to know I can
  register, login, and reset my password
} do

##database_cleaner issue?  Trying to resolve


 # scenario "user can login through tabbed form overlay", js: true do

 #    visit "/"

 #    click_link "Sign In"

 #    fill_in 'username', with: 'pescobar11'
 #    fill_in 'password', with: 'PablowKnowsAll100!'

 #    click_button 'LOGIN'
 #    expect(page).to have_conent('Sign Out')
 #  end
end
