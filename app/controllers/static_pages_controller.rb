class StaticPagesController < ApplicationController
  #отключение проверки токена protect_from_forgery для работы js
  #отключение стандартной шапки и футера
  layout false, only: [:plugin]

  def home
    @lists = List.all
  end

  def help


  end

  #def plugin
   # @list=List.find_by_id(params[:list])
    #@current_ip = request.remote_ip
    #@items = @list.items.paginate(page: params[:page], :per_page => 25)

  #end

end

