class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.string :time
      t.integer :user_id
      t.integer :restaurant_id
    end
  end
end
