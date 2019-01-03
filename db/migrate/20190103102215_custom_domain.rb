class CustomDomain < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :custom_domain, :string
  end
end
