require 'rails_helper'

# As a prospective user
# I want to create an account
# So that I can post items and review them
#
# Acceptance Criteria:
#   - I must provide my first and last name
#   - I must provide a valid email address
#   - I must provide a username
#   - I must provide a password and confirm that password
#   - If I do not perform the above I get an error message
#   - If I provide valid information, I register my account and am authenticated

feature 'user creates account' do
  scenario 'valid and required information provided' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'First Name', with: 'John'
    fill_in 'Last Name', with: 'Smith'
    fill_in 'Email', with: 'jsmith@example.com'
    fill_in 'Username', with: 'JSmith'
    fill_in 'Password', with: 'password1'
    fill_in 'Password Confirmation', with: 'password1'
    click_button 'Sign Up'

    expect(page).to have_content 'You\'re all signed up!'
    expect(page).to have_content 'Sign Out'
  end

  scenario 'required information not provided' do
    visit root_path
    click_link 'Sign Up'
    click_button 'Sign Up'

    expect(page).to have_content 'can\'t be blank'
    expect(page).to_not have_content 'Sign Out'
  end

  scenario 'chosen username already taken' do
    user = create(:user)

    visit root_path
    click_link 'Sign Up'
    fill_in 'First Name', with: 'John'
    fill_in 'Last Name', with: 'Smith'
    fill_in 'Email', with: 'jsmith@example.com'
    fill_in 'Username', with: user.username
    fill_in 'Password', with: 'password1'
    fill_in 'Password Confirmation', with: 'password1'
    click_button 'Sign Up'

    expect(page).to have_content 'Username has already been taken'
    expect(page).to_not have_content 'Sign Out'
  end

  scenario 'password does not match password confirmation' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'First Name', with: 'John'
    fill_in 'Last Name', with: 'Smith'
    fill_in 'Email', with: 'jsmith@example.com'
    fill_in 'Username', with: 'john13'
    fill_in 'Password', with: 'password1'
    fill_in 'Password Confirmation', with: 'password2'
    click_button 'Sign Up'

    expect(page).to have_content 'doesn\'t match'
    expect(page).to_not have_content 'Sign Out'
  end
end
