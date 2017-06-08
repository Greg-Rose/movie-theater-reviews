require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  describe 'DELETE #destroy' do
    let!(:user) do
      create(:user)
    end

    let!(:admin) do
      create(:user, admin: true)
    end

    let!(:state) do
      create(:state)
    end

    let!(:theater) do
      create(:movie_theater, state: state)
    end

    let!(:review) do
      create(:review, movie_theater: theater)
    end

    context "success" do
      it "admin deletes review" do
        sign_in admin
        expect{ delete :destroy, params: { id: review } }.to change(Review, :count).by(-1)
      end
    end

    context "failure" do
      it "does not delete with lack of admin privileges" do
        sign_in user
        expect { delete :destroy, params: { id: review } }.to_not change(Review, :count)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
