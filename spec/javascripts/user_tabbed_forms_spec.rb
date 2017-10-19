require 'spec_helper'
require 'test/unit'
require 'rack/test'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'pry'

Capybara.javascript_driver = :poltergeist
Capybara.app = Sinatra::Application
set(:show_exceptions, false)


feature 'user can access all user forms', %{
  As a potential user
  I want to know I can
  register, login, and reset my password
} do

  scenario "user can view sign-in overlay form", js: true do
    visit "/"

    click_link "Sign In"

    expect(page).to have_content ("Forgot Password?")
    expect(page).to_not have_content("Not registered? Create an account")
  end

  scenario "user can view sign-up overlay form", js: true do
    visit "/"

    click_link "Register"

    expect(page).to have_selector("input[placeholder='Password Confirmation']")
    expect(current_path).to_not have_content('/user/new')
  end

  scenario "user can view reset password overlay form", js: true do
    # visit "/"

    # click_link "Reset your password"

    # expect(page).to have_selector("input[placeholder='Email']")
    # expect(current_path).to_not have_content('/reset')
    #Need to review
  end
end


