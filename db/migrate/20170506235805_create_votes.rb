class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.belongs_to :review, index: true, null: false
      t.belongs_to :user, index: true, null: false
      t.boolean :helpful
      t.timestamps
    end
  end
end
