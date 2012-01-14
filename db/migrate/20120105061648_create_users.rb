class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login, unique: true
      t.string :email
      t.string :password_digest

      t.timestamps
    end
    add_index :users, :login
    add_index :users, :email
  end
end
