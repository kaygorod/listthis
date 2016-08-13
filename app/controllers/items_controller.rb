class ItemsController < ApplicationController
  load_and_authorize_resource only: [:create, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  #before_action :correct_user,       only: [:destroy, :edit]
  layout false, only: [:show, :new_comment]
  #before_filter :set_access_control_headers


  def show
    @item = Item.find(params[:id])
    @list = List.friendly.find(params[:list_id])
  end

  def item_comments
    @item = Item.find(params[:id])
    @list = @item.list
    respond_to do |format|
        format.html
        format.js
    end
  end

  def new_comment
    allow_iframe
    @list = List.friendly.find(params[:list_id])
    @item = Item.find(params[:id])
  end

  def edit
    @list = List.friendly.find(params[:list_id])
    @item = Item.find(params[:id])
  end

  def update
    @list = List.friendly.find(params[:list_id])
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
       flash[:success] = "Изменения сохранены!"
       redirect_to @list
    else
      flash[:danger] = 'Ой! Что-то пошло не так...'
      redirect_to root_path
    end
  end


  def create
   # headers['Access-Control-Allow-Origin'] = '*'
      @list = List.friendly.find(params[:list_id])
      @item = @list.items.build(item_params)
      @item.user_id = current_user.id
      @item.rating = '0'
      @item.comts = '0'
      #@item.title = params[:title]
      #@item.description = params[:description]
      #@item.image = params[:image]
    if @item.save
      respond_to do |format|
        format.html { redirect_to @list}
        format.json {render json: @item}
        format.js
      end
    else
      flash[:danger] = 'Ой! Что-то пошло не так...'
      redirect_to root_path
    end
  end

  def destroy
    @list = List.friendly.find(params[:list_id])
    @item = Item.find(params[:id])
    if @item.present?
       @item.destroy
       respond_to do |format|
        format.html { redirect_to @list}
        format.json { head :no_content }
        format.js
      end
    end
  end

private
  def item_params
    params.require(:item).permit(:title, :description, :image)
  end

  def allow_iframe
    response.headers.delete "X-Frame-Options"
  end
  #def correct_user
  #  @item = current_user.items.find(params[:id])
  #  if @item.nil?
  #    redirect_to root_path
  #  end
  #end

  #def set_access_control_headers
  #  headers['Access-Control-Allow-Origin'] = '*'
  #  headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
  #  headers['Access-Control-Request-Method'] = 'GET, OPTIONS, HEAD, POST'
  #  headers['Access-Control-Allow-Headers'] = 'x-requested-with, Content-Type, Authorization, X-CSRF-Token'
  #end

end
