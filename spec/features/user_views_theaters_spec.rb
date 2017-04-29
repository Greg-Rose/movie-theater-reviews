require 'rails_helper'

# As a user
# I want to view a list of items
# So that I can pick items to review
#
# Acceptance Criteria:
#   - I do not need to be signed in
#   - I can click Movie Theaters from any page to access a list of theaters for review
#   - The list has the title of each theater for review
#   - Each title is a link to that theater's show/review page

feature 'user views list of theaters' do
  let!(:state) do
    create(:state)
  end

  let!(:theaters) do
    create_list(:movie_theater, 5, state: state)
  end

  scenario 'views theaters' do
    visit root_path
    click_link 'Movie Theaters'

    theaters.each do |theater|
      expect(page).to have_content theater.name
    end
  end

  scenario 'click on title of a theater in the list' do
    visit root_path
    click_link 'Movie Theaters'
    click_link theaters[2].name

    expect(page).to have_content theaters[2].name
    expect(page).to have_content theaters[2].city
    expect(page).to have_content theaters[2].state.abbreviation
    expect(page).to have_css 'h3.review-theater-title'
  end
end
