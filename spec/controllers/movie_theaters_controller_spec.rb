require 'rails_helper'

RSpec.describe MovieTheatersController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

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

    context "success" do
      it "admin deletes movie theater" do
        sign_in admin
        expect{ delete :destroy, params: { id: theater } }.to change(MovieTheater, :count).by(-1)
      end
    end

    context "failure" do
      it "does not delete with lack of admin privileges" do
        sign_in user
        expect { delete :destroy, params: { id: theater } }.to_not change(MovieTheater, :count)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
