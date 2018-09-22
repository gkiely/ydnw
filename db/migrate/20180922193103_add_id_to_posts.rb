class AddIdToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :google_doc, :string
  end
end
