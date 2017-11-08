def create_user
  user = User.create(
      :username => 'pescobar',
      :email => 'pablo.escobar@mydoctorloan.com',
      :first_name => 'Pablo',
      :last_name => 'Escobar',
      :password => 'PabloKnowsAll100!',
      :password_confirmation => 'PabloKnowsAll100!'
  )
end

def another_user
  user = User.create(
    :username => 'pescobar22',
    :email => 'pedro.escobar@mydoctorloan.com',
    :first_name => 'Pedro',
    :last_name => 'Escobar',
    :password => 'PedroKnowsAll100!',
    :password_confirmation => 'PedroKnowsAll100!'
    )
end

def create_confirmed_user
  user = User.create(
    :username => 'pescobar',
    :email => 'pablo.escobar@mydoctorloan.com',
    :first_name => 'Pablo',
    :last_name => 'Escobar',
    :password => 'PabloKnowsAll100!',
    :password_confirmation => 'PabloKnowsAll100!',
    :confirm_token => nil,
    :email_confirmed => true
  )
end

def test_user_login
  user = User.create(
    :username => 'pescobar',
    :email => 'pablo.escobar@mydoctorloan.com',
    :first_name => 'Pablo',
    :last_name => 'Escobar',
    :password => 'PabloKnowsAll100!',
    :password_confirmation => 'PabloKnowsAll100!',
    :confirm_token => nil,
    :email_confirmed => true
  )
  visit '/sign-in'

  fill_in 'username', with: user.username
  fill_in 'password', with: user.password

  click_button 'LOGIN'

  user
end
