class AddFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :bio, :string
    add_column :users, :description, :string
    add_column :users, :role, :integer
    add_column :users, :url, :string
  end
end
