class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by_username(params[:id])
    @lists = @user.lists(page: params[:page])
  end
end
