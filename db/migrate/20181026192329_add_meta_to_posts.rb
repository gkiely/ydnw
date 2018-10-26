class AddMetaToPosts < ActiveRecord::Migration[5.2]
  def change
    add_attachment :posts, :meta
  end
end
