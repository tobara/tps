class User < ActiveRecord::Base
  validates :email, :username, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: :true

  has_secure_password

  private

  def validate_password?
    password.present? || password_confirmation.present?
  end
end
