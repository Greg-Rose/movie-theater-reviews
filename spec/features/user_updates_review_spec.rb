require 'rails_helper'

# As an authenticated user
# I want to update my review of a theater
# So that I can correct errors or provide new information
#
# Acceptance Criteria:
#   - I must be signed in
#   - I must be the user who wrote the review
#   - I can click Update Review from the theater's show page
#   - If I'm not signed in or not the user who wrote the review, I can not
#     view the Update Review link or access the page it links to
#   - I can edit the title of the review
#   - I can edit the body of the review
#   - If valid/required information is submitted, the review updates and I am taken to the theaters show page
#   - If valid/required information is not submitted, I am shown an error message

feature 'user updates review' do
  let!(:users) do
    create_list(:user, 2)
  end

  let!(:state) do
    create(:state)
  end

  let!(:theater) do
    create(:movie_theater, state: state)
  end

  let!(:review) do
    create(:review, movie_theater: theater, user: users[0])
  end

  scenario 'required/valid info submitted' do
    sign_in users[0]
    visit movie_theater_path(theater)
    click_link 'Update Review'
    fill_in 'Title', with: 'New Title'
    fill_in 'Body', with: 'New Body'
    click_button 'Update Review'

    expect(page).to have_content 'New Title'
    expect(page).to have_content 'New Body'
    expect(page).to have_content users[0].username
  end

  scenario 'required information not provided' do
    sign_in users[0]
    visit movie_theater_path(theater)
    click_link 'Update Review'
    fill_in 'Title', with: ''
    fill_in 'Body', with: ''
    click_button 'Update Review'

    expect(page).to have_content 'can\'t be blank'
    expect(page).to have_button 'Update Review'
    expect(page).to_not have_css 'h3.review-theater-title'
  end

  scenario 'unable to access page when not signed in' do
    visit movie_theater_path(theater)

    expect(page).to_not have_link 'Update Review'

    visit edit_movie_theater_review_path(theater, review)

    expect(page).to have_content 'You need to sign in or sign up before continuing'
    expect(page).to_not have_content 'Update'
  end

  scenario 'unable to access page as unauthorized user' do
    sign_in users[1]
    visit movie_theater_path(theater)

    expect(page).to_not have_link 'Update Review'

    visit edit_movie_theater_review_path(theater, review)

    expect(page).to have_content 'You Can Only Update Reviews You\'ve Written.'
    expect(page).to_not have_button 'Update Review'
    expect(page).to_not have_link 'Update Review'
  end
end
