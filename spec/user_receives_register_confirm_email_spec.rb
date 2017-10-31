require 'spec_helper'
require 'test/unit'
require 'rack/test'
require 'capybara/rspec'

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('User receives confirmation email', {:type => :feature}) do

  scenario('receives email with confirm token link') do

    ActionMailer::Base.deliveries.clear

    visit '/user/new'

    fill_in 'username', with: 'prodigy_internet'
    fill_in 'password', with: 'Cardinal99!'
    fill_in 'password_confirmation', with: 'Cardinal99!'
    fill_in 'first_name', with: 'Charlie'
    fill_in 'last_name', with: 'Smith'
    fill_in 'email', with: 'charlie.smith@mydoctorloan.com'
    click_button 'Register'

    last_email = ActionMailer::Base.deliveries.first.body.parts[0].to_s

    user = User.first

    expect(last_email).to have_content(user.confirm_token)
    expect(user.email_confirmed).to eq(false)
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end

  scenario('User clicks confirmation link') do

    ActionMailer::Base.deliveries.clear

    visit '/user/new'

    fill_in 'username', with: 'prodigy_internet'
    fill_in 'password', with: 'Cardinal99!'
    fill_in 'password_confirmation', with: 'Cardinal99!'
    fill_in 'first_name', with: 'Charlie'
    fill_in 'last_name', with: 'Smith'
    fill_in 'email', with: 'charlie.smith@mydoctorloan.com'
    click_button 'Register'

    user = User.first
    confirm_token = user.confirm_token

    confirm_email = ActionMailer::Base.deliveries.first.body.parts[0].to_s
    confirm_link = confirm_email.match(/https?:\/\/[\S]+/)[0]

    visit confirm_link

    expect(User.first.email_confirmed).to eq(true)
    expect(User.first.confirm_token).to_not have_content(confirm_token)
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end
end
