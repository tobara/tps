class User < ActiveRecord::Base
  validates :email, :username, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: :true

  has_secure_password

end
