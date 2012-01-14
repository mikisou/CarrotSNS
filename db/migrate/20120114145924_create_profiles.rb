class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :nick_name, unique: true
      t.string :locale, default: "ja"
      t.integer :age
      t.text :comment
      t.references :user

      t.timestamps
    end
    add_index :profiles, :nick_name
    add_index :profiles, :user_id
  end
end
