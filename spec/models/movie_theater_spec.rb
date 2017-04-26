require 'rails_helper'

RSpec.describe MovieTheater, type: :model do
  it { should have_valid(:name).when('Test Theater', 'Showcase Cinemas Foxboro') }
  it { should_not have_valid(:name).when('', nil) }

  it { should have_valid(:city).when('North Blah', 'Foxboro') }
  it { should_not have_valid(:city).when('', nil) }

  it { should have_valid(:state_id).when(1, 12) }
  it { should_not have_valid(:state_id).when('', nil) }

  it { should have_valid(:zipcode).when(nil, '', '01010') }
  it { should_not have_valid(:zipcode).when(00, 788787, 'test', '89', '747474') }

  it { should have_valid(:user_id).when(1, 13) }
  it { should_not have_valid(:user_id).when(nil, '') }

  it { should have_valid(:website).when(nil, '', 'www.example.com', 'example.com', 'example.net', 'http://www.example.com', 'http://example.com', 'example.com/test') }
  it { should_not have_valid(:website).when('example', 'examplecom', '.comexamplewww.') }
end
