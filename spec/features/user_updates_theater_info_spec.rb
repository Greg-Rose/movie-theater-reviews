require 'rails_helper'

# As an authenticated user
# I want to update an item's information
# So that I can correct errors or provide new information
#
# Acceptance Criteria:
#   - I must be signed in
#   - I must be the user who added the theater
#   - I must be able to click Update Theater from the theater's show page
#   - If I'm not signed in or not the user who added the theater, I can not
#     view the Update Theater link or access the page it links to
#   - I can edit the name of the theater
#   - I can edit the city and state of the theater
#   - I can optionally provide or edit the address, zipcode, and website of the theater
#   - If valid/required information is submitted, the theater updates and I am taken to the theaters show page
#   - If valid/required information is not submitted, I am shown an error message

feature 'user updates theater' do
  let!(:users) do
    create_list(:user, 2)
  end

  let!(:state) do
    create(:state)
  end

  let!(:state_2) do
    create(:state, name: "New York", abbreviation: "NY")
  end

  let!(:theater) do
    create(:movie_theater, state: state, user: users[0])
  end

  scenario 'required/valid info submitted' do
    sign_in users[0]
    visit movie_theater_path(theater)
    click_link 'Update Theater'
    fill_in 'Name', with: 'New Name'
    fill_in 'City', with: 'New City'
    select('New York', from: 'State')
    click_button 'Update Movie Theater'

    expect(page).to have_content 'Movie Theater Updated!'
    expect(page).to have_content 'New Name'
    expect(page).to have_content 'New City'
    expect(page).to have_content 'NY'
    expect(page).to have_css 'h3.review-theater-title'
  end

  scenario 'required information not provided' do
    sign_in users[0]
    visit movie_theater_path(theater)
    click_link 'Update Theater'
    fill_in 'Name', with: ''
    fill_in 'City', with: ''
    click_button 'Update Movie Theater'

    expect(page).to have_content 'can\'t be blank'
    expect(page).to have_button 'Update Movie Theater'
    expect(page).to_not have_css 'h3.review-theater-title'
  end

  scenario 'unable to access page when not signed in' do
    visit movie_theater_path(theater)

    expect(page).to_not have_link 'Update Theater'

    visit edit_movie_theater_path(theater)

    expect(page).to have_content 'You need to sign in or sign up before continuing'
    expect(page).to_not have_content 'Update Movie Theater'
  end

  scenario 'unable to access page as unauthorized user' do
    sign_in users[1]
    visit movie_theater_path(theater)

    expect(page).to_not have_link 'Update Theater'

    visit edit_movie_theater_path(theater)

    expect(page).to have_content 'You Can Only Update Theaters You\'ve Added!'
    expect(page).to_not have_content 'Update Movie Theater'
  end
end
