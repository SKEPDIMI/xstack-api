class AddDefaultFields < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :bio, :string, default: '', null: false
    change_column :users, :description, :string, default: '', null: false
    change_column :users, :url, :string, default: '', null: false
    change_column :users, :role, :integer, default: 0, null: false
    change_column :users, :name, :string, null: false
  end
end
