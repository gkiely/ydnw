class User < ApplicationRecord
  DOMAIN_MAPPING = {
    "patwalls.co" => "patwalls"
  }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts

  validates_uniqueness_of :email, :username
  validates_presence_of :email, :username

  validates_format_of :username, with: /\A[A-Za-z0-9]+\z/

  has_attached_file :avatar, styles: { thumb: "100x100" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
