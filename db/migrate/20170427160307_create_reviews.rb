class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.belongs_to :movie_theater, index: true, null: false
      t.belongs_to :user, index: true, null: false

      t.timestamps
    end
  end
end
