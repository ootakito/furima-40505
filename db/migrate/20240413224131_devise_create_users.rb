class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
        t.string :nickname, null: false
        t.string :last_name, null: false
        t.string :first_name, null: false
        t.string :last_name_kana, null: false
        t.string :first_name_kana, null: false
        t.string :email, null: false, unique: true
        t.string :encrypted_password, null: false
        t.date :birthdate, null: false
        t.timestamps
    end
    add_index :users, :email,                unique: true
    #add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
