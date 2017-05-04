class AddRatingToReviews < ActiveRecord::Migration[5.0]
  def up
    add_column :reviews, :rating, :integer
    Review.reset_column_information
    Review.update_all(rating: 0)
    change_column_null :reviews, :rating, false
  end

  def down
    remove_column :reviews, :rating
  end
end
