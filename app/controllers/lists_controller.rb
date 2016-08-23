class ListsController < ApplicationController
  load_and_authorize_resource :find_by => :slug, only: [:new, :create, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  #before_action :correct_user,       only: [:destroy, :edit]
  layout false, only: [:iframe, :plugin, :items_form_iframe]
  #отключение проверки токена protect_from_forgery для работы js
  skip_before_action :verify_authenticity_token , :only => [:show, :list_items, :new_item]

  #protect_from_forgery except: [:sort_time_desc, :sort_time_asc]
  #before_filter :set_access_control_headers
  layout false, only: [:new_item]

  def new_item
    allow_iframe
    @list = List.friendly.find(params[:id])
    if params[:item]
    @item = Item.find(params[:item])
    respond_to do |format|
      format.js
      end
    end
  end

  def show

    list_items
    views

    respond_to do |format|
        format.html {render layout: "list"}
        format.js
      end

  end

  def iframe
    allow_iframe
    list_items
    views
    respond_to do |format|
      format.html
      format.js
    end
  end

  #def plugin
   # @list=List.find(params[:id])
    #@current_ip = request.remote_ip
    #@items = @list.items.paginate(page: params[:page], :per_page => 25)
  #end

  #def index
  #  @lists = List.all
  #end

  def edit
    @list = List.friendly.find(params[:id])
  end

  def update
    @list = List.friendly.find(params[:id])
    if @list.update_attributes(list_params)
      flash[:success] = "Изменения сохранены!"
      redirect_to @list
    else
      flash[:danger] = 'Ой! Что-то пошло не так...'
      redirect_to root_path
    end
  end

  #def new
  #end

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
    @list = List.friendly.find(params[:id])
    if @list.present?
       @list.destroy
    end
    flash[:success] = 'Список удален!'
    redirect_to current_user
  end


  #def sort_time_desc
  #  headers['Access-Control-Allow-Origin'] = '*'
  #  list_items
  #end

  #def sort_time_asc
  #  headers['Access-Control-Allow-Origin'] = '*'
  #  list_items
  #end

  #def sort_comts_desc
  #  list_items
  #end

  #def sort_comts_asc
  #  list_items
  #end

  #def sort_rating_desc
  #  list_items
  #end

  #def sort_rating_asc
  #  list_items
  #end

private

  def views
    @list.views += 1
    @list.save
  end

  def list_items
    if params[:sort] == "rating_desc"
    sort_order = "rating desc"
    end
    if params[:sort] == "rating_asc"
    sort_order = "rating asc"
    end
    if params[:sort] == "comts_desc"
    sort_order = "comts desc"
    end
    if params[:sort] == "comts_asc"
    sort_order = "comts asc"
    end
    if params[:sort] == "created_at_desc"
    sort_order = "created_at desc"
    end
    if params[:sort] == "created_at_asc"
    sort_order = "created_at asc"
    end
    @list = List.friendly.find(params[:id])
    @current_ip = request.remote_ip
    @items = @list.items.paginate(page: params[:page], :per_page => 25).order(sort_order)
  end

  def list_params
    params.require(:list).permit(:title, :description, :image)
  end

  def allow_iframe
    response.headers.delete "X-Frame-Options"
  end

  #def correct_user
  #  @list = current_user.lists.friendly.find(params[:id])
  #  if @list.nil?
  #    redirect_to root_path
  #  end
  #end
 # def set_access_control_headers
 #   headers['Access-Control-Allow-Origin'] = '*'
 #   headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
 #   headers['Access-Control-Request-Method'] = 'GET, OPTIONS, HEAD, POST'
 #   headers['Access-Control-Allow-Headers'] = 'x-requested-with,Content-Type, Authorization'
 # end

end
