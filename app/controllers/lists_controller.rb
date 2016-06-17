class ListsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :destroy]
  before_action :correct_user,       only: [:destroy, :edit]


  def show
    list_items
    respond_to do |format|
        format.html
        format.js
      end
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
      flash[:success] = "Изменения сохранены!"
      redirect_to @list
    else
      flash[:danger] = 'Ой! Что-то пошло не так...'
      redirect_to root_path
    end
  end

  def new
  end

  def create
      @list = current_user.lists.build(list_params)
      @list.views = '0'
    if @list.save
      flash[:success] = "Новый список создан! Теперь добавьте в него пункты."
      redirect_to @list
    else
      flash[:danger] = 'Ой! Что-то пошло не так...'
      redirect_to root_path
  end
end


  def destroy
    @list = List.find(params[:list_id])
    if @list.present?
       @list.destroy
    end
    flash[:success] = 'Список удален!'
    redirect_to current_user
  end


  def sort_time_desc
    list_items
  end

  def sort_time_asc
    list_items
  end

  def sort_comts_desc
    list_items
  end

  def sort_comts_asc
    list_items
  end

  def sort_rating_desc
    list_items
  end

  def sort_rating_asc
    list_items
  end

private

  def list_items
    @current_ip = request.remote_ip
    @list = List.find(params[:id])
    @items = @list.items.all.paginate(page: params[:page], :per_page => 5)
  end

  def list_params
    params.require(:list).permit(:title, :description, :image)
  end

  def correct_user
    @list = current_user.lists.find(params[:id])
    if @list.nil?
      redirect_to root_path
    end
  end

end
