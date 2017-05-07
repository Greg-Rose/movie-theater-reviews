require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should have_valid(:user_id).when(1, 13) }
  it { should_not have_valid(:user_id).when(nil, '') }

  it { should have_valid(:review_id).when(1, 13) }
  it { should_not have_valid(:review_id).when(nil, '') }
end
