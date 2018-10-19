class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user

  scope :published, -> { where(is_published: true) }
  scope :most_recent_first, -> { order(published: :desc) }
end
