require 'rails_helper'

# As an authenticated user
# I want to add a theater
# So that others can review it
#
# Acceptance Criteria:
#   - I must be signed in
#   - I must be able to click Add Movie Theater from any page
#   - I must provide the name of the theater
#   - I must provide the city and state of the theater
#   - I can optionally provide the address, zipcode, and website of the theater
#   - If valid/required information is submitted, I am taken to the theaters show page
#   - If valid/required information is not submitted, I am shown an error message

feature 'user adds new theater' do
  let!(:user) do
    create(:user)
  end

  let!(:state) do
    create(:state)
  end

  scenario 'only required info submitted' do
    sign_in user
    visit root_path
    click_link 'Add Movie Theater'
    fill_in 'Name', with: 'Showcase Cinemas Foxboro'
    fill_in 'City', with: 'Foxboro'
    select('Massachusetts', from: 'State')
    click_button 'Add Movie Theater'

    expect(page).to have_content 'New Movie Theater Added!'
    expect(page).to have_content 'Showcase Cinemas Foxboro'
    expect(page).to have_content 'MA'
    expect(page).to have_content 'Review This Theater'
  end

  scenario 'all info submitted' do
    sign_in user
    visit root_path
    click_link 'Add Movie Theater'
    fill_in 'Name', with: 'Showcase Cinemas'
    fill_in 'Address', with: '123 Main Street'
    fill_in 'City', with: 'Foxboro'
    select('Massachusetts', from: 'State')
    fill_in 'Zipcode', with: '01234'
    fill_in 'Website', with: 'www.example.com'
    click_button 'Add Movie Theater'

    expect(page).to have_content 'New Movie Theater Added!'
    expect(page).to have_content 'Showcase Cinemas'
    expect(page).to have_content 'Foxboro, MA 01234'
    expect(page).to have_link 'Theater\'s Website'
    expect(page).to have_content 'Review This Theater'
  end

  scenario 'required information not provided' do
    sign_in user
    visit root_path
    click_link 'Add Movie Theater'
    click_button 'Add Movie Theater'

    expect(page).to have_content 'can\'t be blank'
    expect(page).to have_button 'Add Movie Theater'
    expect(page).to_not have_content 'Review This Theater'
  end

  scenario 'unable to access page when not signed in' do
    visit root_path

    expect(page).to_not have_link 'Add Movie Theater'

    visit new_movie_theater_path

    expect(page).to have_content 'You need to sign in or sign up before continuing'
    expect(page).to_not have_content 'Add Movie Theater'
  end
end
