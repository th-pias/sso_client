class AddColumnUidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uid, :string
    add_column :users, :status, :string
  end
end
