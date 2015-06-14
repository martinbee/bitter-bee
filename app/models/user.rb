class User < ActiveRecord::Base

  validates :username, presence: true, length: {maximum:30}, uniqueness: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum:250},
  format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  validates :password, :password_confirmation, presence: true, length: {minimum: 6}

  has_secure_password
  has_many :posts
  mount_uploader :photo, PhotoUploader
  acts_as_followable
  acts_as_follower
end
