require "rails_helper"

RSpec.describe StateSeeder do
  it "doesn't create duplicate records on multiple runs" do
    StateSeeder.seed!
    initial_count = State.count
    StateSeeder.seed!
    expect(State.count).to eq(initial_count)
  end
end
