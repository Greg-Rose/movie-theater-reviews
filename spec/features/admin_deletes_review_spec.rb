require 'rails_helper'

# As an admin
# I want to delete a review
# So that I can remove inappropriate content from the site
#
# Acceptance Criteria:
#   - I must be signed in with admin privileges
#   - I can click Delete Review on any review
#   - Clicking Delete Review will delete the review

feature 'admin deletes a review' do
  let!(:admin) do
    create(:user, admin: true)
  end

  let!(:user) do
    create(:user)
  end

  let!(:state) do
    create(:state)
  end

  let!(:theater) do
    create(:movie_theater, state: state)
  end

  let!(:review) do
    create(:review, movie_theater: theater)
  end

  scenario 'delete review' do
    sign_in admin
    visit movie_theater_path(theater)
    click_button 'Delete Review'

    expect(page).to have_content 'Review Deleted.'
    expect(Review.where(movie_theater_id: theater.id)).to be_empty
    expect(page).to_not have_content review.title
    expect(page).to_not have_content review.body
  end
end
