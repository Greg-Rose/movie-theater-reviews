require 'rails_helper'

# As an authenticated user
# I want to update my information
# So that I can keep my profile up to date
#
# Acceptance Criteria:
#   - I must be signed in
#   - I must be able to access my account from any page
#   - My current info is filled in the form (excluding password)
#   - I can edit one or many fields and click submit changes
#   - If I do not provide valid changes I get an error
#   - If I provide valid changes, my account is updated

feature 'user updates account information' do
  let!(:user) do
    create(:user)
  end

  scenario 'updates account information' do
    sign_in user
    visit root_path
    click_link 'My Account'
    fill_in 'Email', with: 'updated@example.com'
    fill_in 'Current Password', with: 'password1'
    click_button 'Update Account'

    expect(page).to have_content 'Your account has been updated!'

    click_link 'My Account'

    expect(page).to have_field 'Email', with: 'updated@example.com'
  end

  scenario 'valid or required information not provided' do
    sign_in user
    visit root_path
    click_link 'My Account'
    fill_in 'Email', with: ''
    click_button 'Update Account'

    expect(page).to have_content 'can\'t be blank'
  end
end
