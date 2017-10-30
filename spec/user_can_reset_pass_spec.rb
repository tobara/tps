require 'spec_helper'
require 'test/unit'
require 'rack/test'
require 'capybara/rspec'

Capybara.app = Sinatra::Application
set(:show_exceptions, false)


describe('User can reset password', {:type => :feature}) do

  it('receives email with reset token link') do
    ActionMailer::Base.deliveries.clear

    user = create_confirmed_user

    visit '/'

    click_link 'Reset your password'

    fill_in 'email', with: user.email

    click_button 'RESET PASSWORD'

    last_email = ActionMailer::Base.deliveries.first.body.parts[0].to_s

    expect(page).to have_content('to reset your password')

    expect(last_email).to have_content(user.reset_token)
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end

  it('resets password from reset token link') do
    ActionMailer::Base.deliveries.clear

    user = create_confirmed_user

    visit '/'

    click_link 'Reset your password'

    fill_in 'email', with: user.email

    click_button 'RESET PASSWORD'

    reset_email = ActionMailer::Base.deliveries.first.body.parts[0].to_s
    reset_link = reset_email.match(/https?:\/\/[\S]+/)[0]

    visit reset_link

    fill_in 'password', with: 'newpass1'
    fill_in 'password_confirmation', with: 'newpass1'

    click_button 'RESET PASSWORD'

    expect(page).to have_content('Your password has been updated.')
    expect(page).not_to have_content('Password reset failed.')
  end
end
