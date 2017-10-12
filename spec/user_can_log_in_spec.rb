require 'spec_helper'
require 'test/unit'
require 'rack/test'
require 'capybara/rspec'

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('User can login', {:type => :feature}) do

  it('logs me in with valid username and password') do
    user = create_user
    visit('/')
    click_link 'Sign In'

    fill_in 'username', with: user.username
    fill_in 'password', with: user.password

    click_button 'LOGIN'

    expect(page).not_to have_content('EDS Tuition Portal')
    expect(page).to have_content('Sign Out')
  end

  it('logs me in with valid email and password') do
    user = create_user
    visit('/sign-in')

    fill_in 'username', with: user.email
    fill_in 'password', with: user.password

    click_button 'LOGIN'

    expect(page).not_to have_content('EDS Tuition Portal')
    expect(page).to have_content('Sign Out')
  end

  it('does not log me in with invalid credentials') do
    user = create_user

    visit('/sign-in')

    fill_in 'username', with: user.email
    fill_in 'password', with: 'MadeUpPass1'

    click_button 'LOGIN'

    expect(page).not_to have_content('Sign Out')
    expect(page).to have_content('Login Failed')
  end
end


