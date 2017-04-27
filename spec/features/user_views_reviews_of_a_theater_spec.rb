require 'rails_helper'

# As a user
# I want to view a list of reviews for a theater
# So that I can read the reviews for that theater
#
# Acceptance Criteria:
#   - I do not need to be signed in
#   - I must be on the show page for the theater I want the reviews for
#   - The list has the title of each theater for review
#   - Each title is a link to that theater's show/review page

feature 'user views reviews of a theater' do
  let!(:state) do
    create(:state)
  end

  let!(:theater) do
    create(:movie_theater, state: state)
  end

  let!(:reviews) do
    create_list(:review, 3, movie_theater: theater)
  end

  scenario 'view reviews' do
    visit movie_theater_path(theater)

    reviews.each do |review|
      expect(page).to have_content review.title
      expect(page).to have_content review.body
      expect(page).to have_content review.user.username
    end
  end
end
