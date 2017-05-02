require 'rails_helper'

# As an admin
# I want to view a list of users
# So that I can see who is using my app
#
# Acceptance Criteria:
#   - I must be signed in with admin privileges
#   - I can click View Users from any page to access a list of the app's users
#   - The list has the username of each user
#   - Each username is a link to that user's show/info page

feature 'admin views list of users' do
  let!(:admin) do
    create(:user, admin: true)
  end

  let!(:users) do
    create_list(:user, 3)
  end

  scenario 'views users' do
    sign_in admin
    visit root_path
    click_link 'View Users'

    users.each do |user|
      expect(page).to have_content user.username
    end
  end

  scenario 'click on username of a user in the list' do
    sign_in admin
    visit root_path
    click_link 'View Users'
    click_link users[1].username

    expect(page).to have_content users[1].first_name
    expect(page).to have_content users[1].last_name
    expect(page).to have_content users[1].email
    expect(page).to have_content users[1].username
    expect(page).to have_content users[1].created_at.strftime('%x')
  end

  scenario 'not signed in' do
    visit root_path

    expect(page).to_not have_link 'View Users'

    visit admin_users_path

    expect(page).to have_current_path root_path
    expect(page).to_not have_content 'Users'
  end

  scenario 'does\'t have admin privileges' do
    sign_in users[1]
    visit root_path

    expect(page).to_not have_link 'View Users'

    visit admin_users_path

    expect(page).to have_current_path root_path
    expect(page).to_not have_content 'Users'
  end
end
