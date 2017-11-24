require 'spec_helper'
require 'test/unit'
require 'rack/test'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'pry'

Capybara.app = Sinatra::Application
Capybara.javascript_driver = :poltergeist

describe('Auth user can change username', {:type => :feature}) do

  scenario 'auth is allowed to edit username without going to form page', js: true do
    user = test_user_login

    visit '/dashboard'

    click_link 'Account Settings'

    page.find('#nameAction').click

    expect(page).to_not have_current_path '/user/:id/settings/username/edit'
    expect(page).to have_content 'PARENT LAST NAME'
  end

  # scenario 'auth is able to save new username', js: true do
  #   user = test_user_login

  #   visit '/dashboard'

  #   click_link 'Account Settings'

  #   page.find('#nameAction').click

  #   fill_in 'usernameField', with: 'newUserName'

  #   page.find('#nameAction').click

  #   expect(page).to have_content 'Your Username has been changed.'
  #   expect(page).to_not have_content 'Username change failed.'
  # end

end
