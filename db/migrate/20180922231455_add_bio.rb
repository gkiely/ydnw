class AddBio < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :bio, :string
  end
end
