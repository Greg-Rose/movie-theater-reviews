class CreateMovieTheaters < ActiveRecord::Migration[5.0]
  def change
    create_table :movie_theaters do |t|
      t.string :name, null: false
      t.string :address
      t.string :city, null: false
      t.belongs_to :state, index: true, null: false
      t.string :zipcode, limit: 5
      t.string :website
      t.belongs_to :user, index: true, null: false

      t.timestamps
    end
  end
end
