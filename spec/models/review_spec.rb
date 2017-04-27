require 'rails_helper'

RSpec.describe Review, type: :model do
  it { should have_valid(:title).when('Test Review', 'This place is Awesome') }
  it { should_not have_valid(:title).when('', nil) }

  it { should have_valid(:body).when('Etc. etc. etc.') }
  it { should_not have_valid(:body).when('', nil) }

  it { should have_valid(:user_id).when(1, 13) }
  it { should_not have_valid(:user_id).when(nil, '') }

  it { should have_valid(:movie_theater_id).when(1, 13) }
  it { should_not have_valid(:movie_theater_id).when(nil, '') }
end
