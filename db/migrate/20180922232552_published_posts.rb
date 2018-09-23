class PublishedPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :is_published, :boolean, default: false
  end
end
