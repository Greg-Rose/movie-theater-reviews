require 'rails_helper'

# As an authenticated user
# I want to vote on a review
# So that others can know if I found the review helpful or not
#
# Acceptance Criteria:
#   - I must be signed in
#   - I must be on the show page for the theater with the review I want to vote on
#   - To the left of the review I can click upvote or downvote
#   - I can only vote once per review
#   - I can not vote on my own review
#   - If I have not yet voted on the review, my vote is submitted and the vote score for the review changes to reflect that
#   - If I have already voted on the review and I try to vote the same again, I am shown an error message

feature 'user votes on a review' do
  let!(:users) do
    create_list(:user, 2)
  end

  let!(:theater) do
    create(:movie_theater, state: create(:state))
  end

  let!(:review) do
    create(:review, movie_theater: theater, user: users[0])
  end

  scenario 'upvote cast succesfully' do
    sign_in users[1]
    visit movie_theater_path(theater)
    click_link 'Yes'

    expect(page).to have_current_path movie_theater_path(theater)
    expect(page).to have_content '1 person'
    expect(page).to have_content 'Thank you for your feedback!'
  end

  scenario 'unsuccessfully try to upvote again' do
    sign_in users[1]
    visit movie_theater_path(theater)
    click_link 'Yes'
    click_link 'Yes'

    expect(page).to have_content '1 person'
    expect(page).to have_content 'You can change your answer but you can\'t answer again.'
  end

  scenario 'downvote cast succesfully' do
    sign_in users[1]
    visit movie_theater_path(theater)
    click_link 'No'

    expect(page).to have_current_path movie_theater_path(theater)
    expect(page).to_not have_content 'person'
    expect(page).to_not have_content 'people'
    expect(page).to have_content 'Thank you for your feedback!'
  end

  scenario 'unsuccessfully try to downvote again' do
    sign_in users[1]
    visit movie_theater_path(theater)
    click_link 'No'
    click_link 'No'

    expect(page).to_not have_content 'person'
    expect(page).to_not have_content 'people'
    expect(page).to have_content 'You can change your answer but you can\'t answer again.'
  end

  scenario 'unsuccessfully try to vote on one\'s own review' do
    sign_in users[0]
    visit movie_theater_path(theater)
    click_link 'Yes'

    expect(page).to_not have_content 'person'
    expect(page).to_not have_content 'people'
    expect(page).to have_content 'You can\'t vote on your own reviews'
  end

  scenario 'not signed in' do
    visit movie_theater_path(theater)
    click_link 'Yes'

    expect(page).to have_content 'You need to sign in'
  end
end
