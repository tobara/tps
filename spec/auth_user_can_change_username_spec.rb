require 'spec_helper'
require 'test/unit'
require 'rack/test'
require 'capybara/rspec'

Capybara.app = Sinatra::Application
set(:show_exceptions, false)


describe('Auth user can change their username', {:type => :feature}) do

  scenario('authenticated user can change username form') do

    user = test_user_login

    visit '/dashboard'

    click_link 'Account Settings'

    click_link 'change'

    expect(page).to have_button('Save')
    expect(page).to_not have_content('Account Settings')
  end
end
