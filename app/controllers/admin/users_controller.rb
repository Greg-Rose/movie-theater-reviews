module Admin
  class UsersController < ApplicationController
    before_action :authorize_admin

    def index
      @users = User.all.order(:username)
    end

    def show
      @user = User.find(params[:id])
    end

    private

    def authorize_admin
      if !current_user || !current_user.admin?
        redirect_to root_path
      end
    end
  end
end
