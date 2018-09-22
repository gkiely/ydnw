class AddGoogleColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :google_auth_token, :string
    add_column :users, :google_refresh_token, :string
    add_column :users, :google_expires_at, :datetime
  end
end
