class CreateStates < ActiveRecord::Migration[5.0]
  def change
    create_table :states do |t|
      t.string :name, null: false
      t.string :abbreviation, null: false, limit: 2

      t.timestamps
    end
    add_index :states, :name, unique: true
    add_index :states, :abbreviation, unique: true
  end
end
