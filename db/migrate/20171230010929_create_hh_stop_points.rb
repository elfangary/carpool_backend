class CreateHhStopPoints < ActiveRecord::Migration[5.1]
  def change
    create_table :hh_stop_points do |t|
      t.integer :booked_seats
      t.string :confirm, :default => "pending"
      t.integer :points_on_hold, :default => 0
      t.belongs_to :hh, foreign_key: { to_table: :users }
      t.belongs_to :stop_point

      t.timestamps
    end
  end
end
