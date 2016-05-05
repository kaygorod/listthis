class ItemsController < ApplicationController

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end


  def create
      @list = List.find(params[:list_id])
      @item = @list.items.build(item_params)
      @item.user_id = current_user.id
    if @item.save
      redirect_to @list
    else
      render 'static_pages/home'
    end
  end

private
  def item_params
    params.require(:item).permit(:title, :description, :image)
  end
end
