class Post < ApplicationRecord
  belongs_to :user

  scope :published, -> { where(is_published: true) }
  scope :most_recent_first, -> { order(published: :desc) }
end
