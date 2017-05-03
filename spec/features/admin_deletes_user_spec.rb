require 'rails_helper'

# As an admin
# I want to delete a user
# So that I can stop troublesome users from using the site
#
# Acceptance Criteria:
#   - I must be signed in with admin privileges
#   - I can click Delete User from a users show/info page
#   - Clicking Delete User will soft delete their account
#   - The users show/info page will now show that the account has been deleted

feature 'admin deletes a user' do
  let!(:admin) do
    create(:user, admin: true)
  end

  let!(:user) do
    create(:user)
  end

  scenario 'delete user' do
    sign_in admin
    visit root_path
    click_link 'View Users'
    click_link user.username
    click_button 'Delete User'

    expect(page).to have_content 'User deleted.'
    expect(User.find(user.id).deleted_at).to_not be_nil
    expect(page).to have_content 'Deleted'
    expect(page).to_not have_button 'Delete User'
  end
end
