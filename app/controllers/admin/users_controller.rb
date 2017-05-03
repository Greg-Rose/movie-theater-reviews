module Admin
  class UsersController < ApplicationController
    before_action :authorize_admin

    def index
      @users = User.all.order(:username)
    end

    def show
      @user = User.find(params[:id])
    end

    def destroy
      @user = User.find(params[:id])
      @user.soft_delete
      flash[:notice] = "User deleted."
      redirect_to admin_user_path(@user)
    end

    private

    def authorize_admin
      if !current_user || !current_user.admin?
        redirect_to root_path
      end
    end
  end
end
