require 'rails_helper'

# As an admin
# I want to delete a theater
# So that I can remove inappropriate content from the site
#
# Acceptance Criteria:
#   - I must be signed in with admin privileges
#   - I can click Delete Theater on any theater's show/info page
#   - Clicking Delete Theater will delete the theater and it's reviews

feature 'admin deletes a theater' do
  let!(:admin) do
    create(:user, admin: true)
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

  scenario 'delete theater' do
    sign_in admin
    visit movie_theater_path(theater)
    click_button 'Delete Theater'

    expect(page).to have_content 'Movie Theater Deleted.'
    expect(page).to_not have_content theater.name

    expect(Review.where(movie_theater_id: theater.id)).to be_empty
  end
end
