class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user

  has_attached_file :meta, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :meta, content_type: /\Aimage\/.*\z/

  scope :published, -> { where(is_published: true) }
  scope :draft, -> { where(is_published: false) }
  scope :most_recent_first, -> { order(published: :desc) }

  def should_generate_new_friendly_id?
    (slug.blank? || self.title_changed?) && !self.is_published
  end
end
