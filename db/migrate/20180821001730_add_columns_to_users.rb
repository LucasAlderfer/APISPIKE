class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :star_url, :string
    add_column :users, :followers, :integer
    add_column :users, :following, :integer
  end
end
