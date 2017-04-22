require 'rails_helper'

# As an unauthenticated user
# I want to sign in
# So that I can post items and review them
#
# Acceptance Criteria:
#   - I must provide my email
#   - I must provide my password
#   - If I do not provide the above that matches an account,
#     I get an error message
#   - If I provide valid information, I am authenticated

feature 'user signs in' do
  let!(:user) do
    create(:user)
  end

  scenario 'valid username and password provided' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content 'You\'re signed in!'
    expect(page).to have_content 'Sign Out'
  end

  scenario 'invalid info provided' do
    visit root_path
    click_link 'Sign In'
    click_button 'Sign In'

    expect(page).to have_content 'Invalid'
    expect(page).to_not have_content 'Sign Out'
  end
end
