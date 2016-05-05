class VotesController < ApplicationController
  def create
    @list = List.find(params[:list_id])
    @item = Item.find(params[:item_id])
    @vote = @item.votes.build(vote_params)
    @vote.user_id = current_user.id
    @vote.user_ip = request.remote_ip
    if @vote.save
       @item.rating += 1
       @item.save
       redirect_to @list
    else
      render 'static_pages/home'
  end
  end

  def update
  end

  def destroy
    @list = List.find(params[:list_id])
    @item = Item.find(params[:item_id])
    @vote = Vote.find(params[:id])
    if @vote.present?
      @vote.destroy
      @item.rating -= 1
      @item.save
    end
    redirect_to @list
  end
def vote_params
    params.require(:vote).permit(:item_id, :user_id, :user_ip)
  end
end
