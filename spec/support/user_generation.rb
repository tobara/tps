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
