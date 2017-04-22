require 'rails_helper'

# As an authenticated user
# I want to sign out
# So that no one else can post items or reviews on my behalf
#
# Acceptance Criteria:
#   - I must be signed in
#   - I must be able to click sign out on any page
#   - I get a message confirming I'm signed out

feature 'user signs out' do
  let!(:user) do
    create(:user)
  end

  scenario 'successfully sign out' do
    sign_in user
    visit root_path
    click_link 'Sign Out'

    expect(page).to have_content 'You\'re signed out.'
    expect(page).to have_content 'Sign In'
  end
end
