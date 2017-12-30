class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.belongs_to :user
      t.string :model, null: false
      t.string :color, null: false
      t.string :number, null: false

      t.timestamps
    end
  end
end
