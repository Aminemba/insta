class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string "name"
      t.string "email"
      t.string "password_digest"
      t.string "image_link"
      t.string "provider"
      t.integer "user_id"

      t.timestamps null: false

    end
  end
end
