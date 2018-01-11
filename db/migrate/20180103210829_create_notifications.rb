class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.belongs_to :user
      t.belongs_to :hh_stop_point
      t.text :body, null: false
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
