require 'rails_helper'

RSpec.describe State, type: :model do
  it { should have_valid(:name).when('Massachusetts', 'New York') }
  it { should_not have_valid(:name).when('', nil) }

  it { should have_valid(:abbreviation).when('MA', 'NY') }
  it { should_not have_valid(:abbreviation).when('', nil, 'MAN', 'M', 'dkjhfj') }
end
