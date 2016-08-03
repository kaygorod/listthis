class PluginController < ApplicationController
  skip_before_action :verify_authenticity_token , :only => [:show, :index]
  layout false, only: [:index, :show]


  def index

  end

  def show
    @list=List.find(params[:id])
    views
    @current_ip = request.remote_ip
    @items = @list.items.paginate(page: params[:page], :per_page => 25)
  end

  private

  def views
    @list.views += 1
    @list.save
  end

end
