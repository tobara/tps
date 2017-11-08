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

  scenario('auth user cannot change username without matching entries') do
    user = test_user_login

    visit '/user/:id/settings/username/edit'

    fill_in 'username', with: 'NewUsername123'
    fill_in 'username_confirmation', with: 'NotSoMuch'

    click_button 'Save'

    expect(page).to have_content('Username change failed.')
    expect(page).to_not have_content('Your Username has been changed')
  end

  scenario('auth can change username with matching entries') do
    user = test_user_login

    visit '/user/:id/settings/username/edit'

    fill_in 'username', with: 'NewUsername123'
    fill_in 'username_confirmation', with: 'NewUsername123'

    click_button 'Save'

    expect(page).to_not have_content('Username change failed.')
    expect(page).to have_content('Your Username has been changed')
  end

  scenario('auth tries to change username to one previously taken') do
    dup_username = another_user
    user = test_user_login

    visit '/user/:id/settings/username/edit'

    fill_in 'username', with: 'pescobar22'
    fill_in 'username_confirmation', with: 'pescobar22'

    click_button 'Save'

    expect(page).to have_content('Username change failed.')
    expect(page).to_not have_content('Your Username has been changed')
  end

  it('correctly updates username') do
    user = test_user_login

    visit '/user/:id/settings/username/edit'

    fill_in 'username', with: 'NewUsername123'
    fill_in 'username_confirmation', with: 'NewUsername123'

    click_button 'Save'

    new_user = User.find_by :id => user.id

    expect(new_user.username).eql?('NewUsername123')
    expect(new_user.username).not_to eql(user.username)
  end
end
