class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.belongs_to :car
      t.belongs_to :driver, foreign_key: { to_table: :users }
      t.date :day
      t.integer :all_seats
      t.string :specific_gender
      t.boolean :smoking
      t.string :status, :default => "pending"

      t.timestamps
    end
  end
end
