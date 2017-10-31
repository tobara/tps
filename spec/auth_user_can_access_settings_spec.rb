require 'spec_helper'
require 'test/unit'
require 'rack/test'
require 'capybara/rspec'

Capybara.app = Sinatra::Application
set(:show_exceptions, false)


describe('Auth user can access their settings', {:type => :feature}) do

  scenario('authenticated user can access settings from dashboard') do

    user = test_user_login


    visit '/dashboard'

    click_link 'Account Settings'

    expect(page).to have_content("#{user.first_name}")
    expect(page).not_to have_content('Nothing to see here')
  end

  scenario('non-authenticated user cannot access settings') do

    user = create_confirmed_user

    visit '/user/:id/settings'

    expect(page).to have_content('Sign In')
    expect(page).to_not have_content(user.first_name)
  end
end
