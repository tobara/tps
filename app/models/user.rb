class User < ActiveRecord::Base
  validates :email, :username, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: :true

  has_secure_password

  def validate_email
    self.email_confirmed = true
    self.confirm_token = nil
  end

  def set_confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  def resetting_password
    self.password = nil
  end

  def set_reset_token
    self.reset_token = SecureRandom.urlsafe_base64.to_s
  end
end
