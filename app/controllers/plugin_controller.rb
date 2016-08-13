class PluginController < ApplicationController
  skip_before_action :verify_authenticity_token , :only => [:show, :index]
  layout false, only: [:index, :show, :item_comments, :list_comments]


  def index
  end

  def show
    @list = List.find(params[:id])
    views
    @current_ip = request.remote_ip
    @items = @list.items.paginate(page: params[:page], :per_page => 25).order(rating: :desc)
  end

  def item_comments
    allow_iframe
    @list = List.find(params[:list])
    @item = Item.find(params[:item])
  end

  def list_comments
    allow_iframe
    @list = List.find(params[:list])
  end

  private

  def views
    @list.views += 1
    @list.save
  end

  def allow_iframe
    response.headers.delete "X-Frame-Options"
  end
end
