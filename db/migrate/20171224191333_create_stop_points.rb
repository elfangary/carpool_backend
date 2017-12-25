class CreateStopPoints < ActiveRecord::Migration[5.1]
  def change
    create_table :stop_points do |t|
      t.time :start_time, null: false
      t.time :end_time, null: false
      t.belongs_to :trip, null: false
      t.belongs_to :location, null: false 

      t.timestamps
    end
  end
end
