class CreateStopPoints < ActiveRecord::Migration[5.1]
  def change
    create_table :stop_points do |t|
      t.time :start_time
      t.time :end_time
      t.belongs_to :trip
      t.belongs_to :location

      t.timestamps
    end
  end
end
