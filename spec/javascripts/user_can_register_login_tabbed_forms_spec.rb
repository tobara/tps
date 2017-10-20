require 'spec_helper'
require 'test/unit'
require 'rack/test'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'pry'

Capybara.javascript_driver = :poltergeist
Capybara.app = Sinatra::Application
set(:show_exceptions, false)
set(:js_erros, false)

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {js_errors: false})
end


feature 'user can login via tabbed form', %{
  As a potential user
  I want to know I can
  register, login, and reset my password
} do

  scenario "user can sign-in through overlay tabbed form", js: true do
    # user = create_confirmed_user
    # visit "/"

    # click_link "Sign In"

    # fill_in 'username', with: user.username
    # fill_in 'password', with: user.password

    # click_button("LOGIN")

    # expect(page).to have_content ("Nothing to see here")
    # expect(page).to_not have_content("Not registered? Create an account")
  end

  # scenario "user can view sign-up overlay form", js: true do
  #   visit "/"

  #   click_link "Register"

  #   expect(page).to have_selector("input[placeholder='Password Confirmation']")
  #   expect(current_path).to_not have_content('/user/new')
  # end

  scenario "user can view reset password overlay form", js: true do
    # visit "/"

    # click_link "Reset your password"

    # expect(page).to have_selector("input[placeholder='Email']")
    # expect(current_path).to_not have_content('/reset')
    #Need to review
  end
end
