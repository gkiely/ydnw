class AddSocialMedia < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :twitter, :string
    add_column :users, :instagram, :string
  end
end
