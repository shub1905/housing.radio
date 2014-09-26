class AddSessionFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :image, :string
    add_column :users, :token, :string
    add_column :users, :expires_at, :datetime
  end
end
