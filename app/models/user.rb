class User < ApplicationRecord

  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, uniqueness: true
  validates :password_confirmation, presence: true, uniqueness: true

  has_secure_password

  def to_param
    :username
  end


end
