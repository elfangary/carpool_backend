class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :phone, null: false
      t.string :profile_pic
      t.string :gender
      t.integer :rate, default: 0
      t.integer :points, default: 100

      t.timestamps
    end
  end
end
