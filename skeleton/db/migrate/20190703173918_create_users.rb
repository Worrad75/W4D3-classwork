class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :user_name, null: false
      t.string :password_digest, null: false
      t.integer :session_token, null: false
    end
    add_index :users, :user_name
  end
end
