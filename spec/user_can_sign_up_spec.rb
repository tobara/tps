require 'spec_helper'
require 'test/unit'
require 'rack/test'
require 'capybara/rspec'

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('New User Sign-Up', {:type => :feature}) do
  it('it gets me the sign-up form') do
    visit('/')
    click_link 'Register'

    expect(page).to have_selector("input[placeholder='Password Confirmation']")
    expect(page).not_to have_content('EDS Tuition Portal')
  end

  it('correctly inputs into sign-up form') do
    visit('/user/new')

    fill_in 'username', with: 'prodigy_internet'
    fill_in 'password', with: 'Cardinal99!'
    fill_in 'password_confirmation', with: 'Cardinal99!'
    fill_in 'first_name', with: 'Charlie'
    fill_in 'last_name', with: 'Smith'
    fill_in 'email', with: 'charlie.smith@mydoctorloan.com'
    click_button 'Register'

    expect(page).to have_content('Registration successful')
    expect(page).not_to have_content('Registration failed.')
  end

    it('incorrectly inputs into sign-up form') do
    visit('/user/new')

    fill_in 'username', with: 'prodigy_internet'
    fill_in 'password', with: 'Cardinal99!'
    fill_in 'password_confirmation', with: '123abc'
    fill_in 'first_name', with: 'Charlie'
    fill_in 'last_name', with: 'Smith'
    fill_in 'email', with: 'charlie.smith@mydoctorloan.com'
    click_button 'Register'

    expect(page).to have_content('Registration failed.')
    expect(page).not_to have_content('Registration successful')
  end
end
