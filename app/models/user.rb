class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts

  validates_uniqueness_of :email, :username
  validates_presence_of :email, :username

  validates_format_of :username, with: /\A[A-Za-z0-9]+\z/
end
