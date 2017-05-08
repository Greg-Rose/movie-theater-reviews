require 'rails_helper'

RSpec.describe Api::V1::VotesController, type: :controller do
  describe "POST /api/v1/votes" do
    let!(:theater) do
      create(:movie_theater, state: create(:state))
    end

    let!(:user) do
      create(:user)
    end

    let!(:review) do
      create(:review, movie_theater: theater)
    end

    it "creates a new upvote" do
      # a Comment object is built but not persisted to the database
      vote = build(:vote, review: review)

      sign_in user

      # Rspec allows us to make a request with HTTP verbs (post),
      # specify a method in the controller to call (:create)
      # as well as specify params to be made available in the method
      post :upvote, params: { vote: vote.attributes }

      # a response object is created when the test receives a response
      # assert that the response has a specific HTTP status
      expect(response).to have_http_status(:created)
      # assert that the response has a header with a specific value
      expect(response.header["Location"]).to match /\/api\/v1\/votes\/upvote/
    end

    it "changes vote to upvote" do
      vote = create(:vote, review: review, user: user, helpful: false)

      sign_in user

      post :upvote, params: { vote: vote.attributes }

      expect(response).to have_http_status(:created)
      expect(response.header["Location"]).to match /\/api\/v1\/votes\/upvote/
    end

    it "doesn't create duplicate upvote" do
      vote = create(:vote, review: review, user: user, helpful: true)

      sign_in user

      post :upvote, params: { vote: vote.attributes }

      expect(response).to have_http_status(:created)
      expect(response.header["Location"]).to match /\/api\/v1\/votes\/upvote/
    end

    it "can't upvote your own review" do
      vote = build(:vote, review: review)

      sign_in review.user

      post :upvote, params: { vote: vote.attributes }

      expect(response).to have_http_status(:created)
      expect(response.header["Location"]).to match /\/api\/v1\/votes\/upvote/
    end

    it "creates a new downvote" do
      # a Comment object is built but not persisted to the database
      vote = build(:vote, review: review, helpful: false)

      sign_in user

      # Rspec allows us to make a request with HTTP verbs (post),
      # specify a method in the controller to call (:create)
      # as well as specify params to be made available in the method
      post :downvote, params: { vote: vote.attributes }

      # a response object is created when the test receives a response
      # assert that the response has a specific HTTP status
      expect(response).to have_http_status(:created)
      # assert that the response has a header with a specific value
      expect(response.header["Location"]).to match /\/api\/v1\/votes\/downvote/
    end

    it "changes vote to downvote" do
      vote = create(:vote, review: review, user: user, helpful: true)

      sign_in user

      post :downvote, params: { vote: vote.attributes }

      expect(response).to have_http_status(:created)
      expect(response.header["Location"]).to match /\/api\/v1\/votes\/downvote/
    end

    it "doesn't create duplicate downvote" do
      vote = create(:vote, review: review, user: user, helpful: false)

      sign_in user

      post :downvote, params: { vote: vote.attributes }

      expect(response).to have_http_status(:created)
      expect(response.header["Location"]).to match /\/api\/v1\/votes\/downvote/
    end

    it "can't downvote your own review" do
      vote = build(:vote, review: review)

      sign_in review.user

      post :downvote, params: { vote: vote.attributes }

      expect(response).to have_http_status(:created)
      expect(response.header["Location"]).to match /\/api\/v1\/votes\/downvote/
    end
  end
end
