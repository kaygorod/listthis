class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :destroy]
  before_action :correct_user,       only: [:destroy, :edit]

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @list = List.find(params[:list_id])
    @item = Item.find(params[:id])
  end

  def update
    @list = List.find(params[:list_id])
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
      @list = List.find(params[:list_id])
      @item = @list.items.build(item_params)
      @item.user_id = current_user.id
      @item.rating = '0'
    if @item.save
      flash[:success] = "Новый пункт добавлен!"
      redirect_to @list
    else
      flash[:danger] = 'Ой! Что-то пошло не так...'
      redirect_to root_path
    end
  end

  def destroy
    @list = List.find(params[:list_id])
    @item = Item.find(params[:id])
    if @item.present?
       @item.destroy
    end
    flash[:success] = 'Пункт удален!'
    redirect_to @list
  end

private
  def item_params
    params.require(:item).permit(:title, :description, :image)
  end

  def correct_user
    @item = current_user.items.find(params[:id])
    if @item.nil?
      redirect_to root_path
    end
  end

end
