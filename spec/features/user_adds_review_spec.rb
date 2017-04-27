require 'rails_helper'

# As an authenticated user
# I want to review a theater
# So that others can read my review
#
# Acceptance Criteria:
#   - I must be signed in
#   - I must be on the show page for the theater I want to review
#   - I can click Add Review to go to the new review page
#   - I must provide a title for my review
#   - I must provide the body of my review
#   - If valid/required information is submitted, I am taken to the theaters show page and my review is now shown
#   - If valid/required information is not submitted, I am shown an error message

feature 'user writes review' do
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
    build(:review, movie_theater: build(:movie_theater, state: state))
  end

  scenario 'required info submitted' do
    sign_in user
    visit movie_theater_path(theater)
    click_link 'Add Review'
    fill_in 'Title', with: review.title
    fill_in 'Body', with: review.body
    click_button 'Add Review'

    expect(page).to have_current_path movie_theater_path(theater)
    expect(page).to have_content review.title
    expect(page).to have_content review.body
    expect(page).to have_content user.username
  end

  scenario 'required/valid info not submitted' do
    sign_in user
    visit movie_theater_path(theater)
    click_link 'Add Review'
    click_button 'Add Review'

    expect(page).to have_content "Review #{theater.name}"
    expect(page).to have_content 'can\'t be blank'
  end

  scenario 'user not signed in' do
    visit movie_theater_path(theater)
    click_link 'Add Review'

    expect(page).to have_content 'need to sign in or sign up'
    expect(page).to_not have_button 'Add Review'

    visit new_movie_theater_review_path(theater)

    expect(page).to have_content 'need to sign in or sign up'
    expect(page).to_not have_button 'Add Review'
  end
end
