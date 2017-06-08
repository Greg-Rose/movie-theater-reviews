require 'rails_helper'

# As an authenticated user
# I want to delete my account
# So that my information is no longer retained by the app
#
# Acceptance Criteria:
#   - I must be signed in
#   - I must go to the my account page
#   - I must click and Delete My Account
#   - If I then click OK, my account is deleted

feature 'user deletes account' do
  let!(:user) do
    create(:user)
  end

  scenario 'successfully delete account' do
    sign_in user
    visit root_path
    click_link 'My Account'
    click_button 'Delete My Account'

    expect(page).to have_content 'Your account has been deleted.'
    expect(page).to_not have_content 'Sign Out'
    expect(User.where(deleted_at: nil)).to eq []
    expect(User.last.deleted_at).to_not be_nil
  end

  scenario 'tries to sign in to deleted account' do
    sign_in user
    visit root_path
    click_link 'My Account'
    click_button 'Delete My Account'
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content 'Sorry, our records show that you deleted your account.'
    expect(page).to have_content 'Sign In'
    expect(page).to_not have_content 'Sign Out'
  end
end
