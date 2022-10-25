class User < ActiveRecord::Base
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates_uniqueness_of :email, case_sensitive: false, message: "is already taken"
  validates :password, length: { minimum: 3 }
  validate :check_passwords
  def check_passwords
    if password != password_confirmation
    end
  end
  def self.authenticate_with_credentials (email, password)
    refinedEmail = email.strip
    user = User.where('lower(email) = ?', refinedEmail.downcase).first
    check = nil
    if user && user.authenticate(password)
      check = user
    end
    check
  end
end
