require 'spec_helper'
require 'test/unit'
require 'rack/test'
require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('User can login', {:type => :feature}) do

  scenario('user logs in with Username') do

    user = create_confirmed_user

    visit('/')
    click_link 'Sign In'

    fill_in 'username', with: user.username
    fill_in 'password', with: user.password

    click_button 'LOGIN'

    expect(page).not_to have_content('EDS Tuition Portal')
    expect(page).to have_content('Sign Out')
  end

  scenario('User logs in with Email') do

    user = create_confirmed_user

    visit('/sign-in')

    fill_in 'username', with: user.email
    fill_in 'password', with: user.password

    click_button 'LOGIN'

    expect(page).not_to have_content('EDS Tuition Portal')
    expect(page).to have_content('Sign Out')
  end

  scenario('User cannot log in with invalid credentials') do

    user = create_confirmed_user

    visit('/sign-in')

    fill_in 'username', with: user.email
    fill_in 'password', with: 'MadeUpPass1'

    click_button 'LOGIN'

    expect(page).not_to have_content('Nothing to see here')
    expect(page).to have_content('Login Failed')
  end
end


