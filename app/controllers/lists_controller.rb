class ListsController < ApplicationController


  def show
    @list = List.find(params[:id])
    @items = @list.items.all
    @list.views += 1
    @list.save
  end

  def index
    @lists = List.all
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    @list = List.find(params[:id])
    if @list.update_attributes(list_params)
        redirect_to @list
    end
  end

  def new
  end

  def create
      @list = current_user.lists.build(list_params)
    if @list.save
      redirect_to current_user
    else
      render 'static_pages/home'
  end
end


  def destroy
  end

private
  def list_params
    params.require(:list).permit(:title, :description, :image)
  end

end
