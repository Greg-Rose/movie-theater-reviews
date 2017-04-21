require 'rails_helper'

RSpec.describe User, type: :model do
  it {should have_valid(:first_name).when('John', 'Jessica')}
  it {should_not have_valid(:first_name).when('', nil)}

  it {should have_valid(:last_name).when('Smith', 'Anderson')}
  it {should_not have_valid(:last_name).when('', nil)}

  it {should have_valid(:email).when('jsmith@test.com', 'user65765@gmail.com')}
  it {should_not have_valid(:email).when('', nil, 'user', 'usergmail.com')}

  it {should have_valid(:username).when('jsmith', 'JessA7829')}
  it {should_not have_valid(:username).when('', nil)}

  it 'has a matching password confirmation for the password' do
    user = User.new
    user.password = 'password1'
    user.password_confirmation = 'password2'

    expect(user).to_not be_valid
    expect(user.errors[:password_confirmation]).to_not be_blank
  end
end
