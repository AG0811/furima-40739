class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :nickname, :string, null: false
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string, null: false
    add_column :users, :read_first, :string, null: false
    add_column :users, :read_last, :string, null: false
    add_column :users, :birthday, :date, null: false
  end
end
