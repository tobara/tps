class User < ActiveRecord::Base
  validates :email, :username,
    presence: true,
    uniqueness: true
  validates :first_name, :last_name,
    presence: :true

  has_secure_password

  def confirm_email
    @email_confirmed = true
    @confirm_token = nil
  end

  def set_confirmation_token
    if confirm_token.blank?
      @confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  def set_reset_token
    if reset_token.blank?
      @reset_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
