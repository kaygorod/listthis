class UsersController < ApplicationController
  before_filter :authenticate_user! # для Devise
  load_and_authorize_resource # for cancancan
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @lists = @user.lists
  end

  def edit

  end

  private

  #def admin_user
   # redirect_to(root_url) unless current_user.present? && current_user.admin?
  #end
end
