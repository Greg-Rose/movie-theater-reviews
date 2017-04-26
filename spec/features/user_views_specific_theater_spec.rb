require 'rails_helper'

# As a user
# I want to view the details about an item
# So that I can get more information about it
#
# Acceptance Criteria:
#   - I do not need to be signed in
#   - On the Movie Theaters page I can click the name of any theater to view it's show/review page
#   - I can see the theater's name, city and state
#   - I can see the theater's address, zipcode and link to website if they were provided

feature 'user views specific theater' do
  let!(:state) do
    create(:state)
  end

  let!(:theater) do
    create(:movie_theater, state: state)
  end

  scenario 'views theater\'s info' do
    visit root_path
    click_link 'Movie Theaters'
    click_link theater.name

    expect(page).to have_content theater.name
    expect(page).to have_content theater.city
    expect(page).to have_content theater.state.abbreviation
    expect(page).to have_content theater.address
    expect(page).to have_content theater.zipcode
    expect(page).to have_link "Theater's Website"
    expect(page).to have_content 'Review This Theater'
  end
end
