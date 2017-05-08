require 'rails_helper'

# As a user
# I want to search for a movie theater
# So that I can find the theater I'm looking for
#
# Acceptance Criteria:
#   - I do not need to be signed in
#   - I must be on the movie theaters index page
#   - I can use the search bar at the top of the page
#   - I must enter the name of the theater I'm looking for
#   - There is no case sensitivity
#   - I can click Search
#   - The page shows all theaters matching my search
#   - If there are no theaters matching my search I receive a message and a link to add a new theater

feature 'user searches for a theater' do
  let!(:state) do
    create(:state)
  end

  let!(:theaters) do
    create_list(:movie_theater, 5, state: state)
  end

  scenario 'multiple theaters matching search' do
    visit movie_theaters_path
    fill_in 'theater-search', with: 'showcase'
    click_button 'Search'

    theaters.each do |theater|
      expect(page).to have_content theater.name
    end
  end

  scenario 'one theater matching search' do
    visit movie_theaters_path
    fill_in 'theater-search', with: theaters[2].name
    click_button 'Search'

    expect(page).to have_content theaters[2].name
  end

  scenario 'no theaters matching search' do
    visit movie_theaters_path
    fill_in 'theater-search', with: 'Japan Stadium'
    click_button 'Search'

    expect(page).to have_content 'We couldn\'t find a movie theater matching your search.'
    expect(page).to have_content 'You can add a new movie theater HERE!'
    expect(page).to have_link 'HERE!'
  end
end
