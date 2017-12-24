class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :hashed_password
      t.string :phone, null: false
      t.string :profile_pic
      t.boolean :gender
      t.integer :rate
      t.integer :points

      t.timestamps
    end
  end
end
