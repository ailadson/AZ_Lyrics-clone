# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  email            :string           not null
#  password_digest  :string           not null
#  session_token    :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  activated        :boolean          default(FALSE)
#  activation_token :string
#

class User < ActiveRecord::Base

  validates :email, :session_token, presence: true
  validates :password_digest, presence: { message: "Must have a password" }
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many :notes

  after_initialize :ensure_session_token, :ensure_activation_token

  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)
    return nil if user.nil?
    return user if user.is_password?(password)
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  attr_reader :password

  def activate!
    self.activated = true
    save!
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    save!
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def ensure_activation_token
    self.activation_token ||= User.generate_session_token
  end
end
