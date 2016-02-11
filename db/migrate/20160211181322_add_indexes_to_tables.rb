class AddIndexesToTables < ActiveRecord::Migration
  def change
    add_index :ratings, :restaurant_id
    add_index :ratings, :user_id
    add_index :ratings, :value

    add_index :restaurants, :last_visited
    add_index :restaurants, :name
  end
end
