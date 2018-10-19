class AddSlug < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :slug, :string, unique: true
  end
end
