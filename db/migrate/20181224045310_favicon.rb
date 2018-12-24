class Favicon < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :favicon, :string
  end
end
