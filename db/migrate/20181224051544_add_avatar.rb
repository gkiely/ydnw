class AddAvatar < ActiveRecord::Migration[5.2]
  def up
    add_attachment :users, :avatar
  end

  def down
    remove_attachment :users, :avatar
  end
end
