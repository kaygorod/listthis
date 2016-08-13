class VotesController < ApplicationController
#before_action :correct_user, only: [:destroy, :update]
load_and_authorize_resource only: [:create, :update, :destroy]
#before_filter :set_access_control_headers
skip_before_action :verify_authenticity_token , :only => [:create, :update, :destroy]

  def create
    @list = List.friendly.find(params[:list_id])
    @item = Item.find(params[:item_id])
    @vote = @item.votes.build(vote_params)
    if signed_in?
      @vote.user_id = current_user.id
    else
      @vote.user_ip = request.remote_ip
    end
    if @vote.save
       if @vote.vot == 'up'
         @item.rating += 1
         @item.save
      else
        @item.rating -= 1
        @item.save
      end
      respond_to do |format|
        format.html { redirect_to @list}
        format.js
      end
    end
  end


  def update
    @list = List.friendly.find(params[:list_id])
    @item = Item.find(params[:item_id])
    @vote = Vote.find(params[:id])
    if @vote.update_attributes(vot_params)
      if @vote.vot == 'up'
        @item.rating += 2
        @item.save
      else
        @item.rating -= 2
        @item.save
      end
      respond_to do |format|
        format.html { redirect_to @list}
        format.js
      end
    end
  end

  def destroy
    @list = List.friendly.find(params[:list_id])
    @item = Item.find(params[:item_id])
    @vote = Vote.find(params[:id])
    if @vote.present?
      if @vote.vot == 'up'
         @item.rating -= 1
         @item.save
      else
        @item.rating += 1
        @item.save
      end
      @vote.destroy
    end
    respond_to do |format|
        format.html { redirect_to @list}
        format.js
      end
  end

    private
      def vote_params
        params.require(:vote).permit(:vot, :item_id, :user_id, :user_ip)
      end

      def vot_params
        params.require(:vote).permit(:vot)
      end


      def correct_user
        if signed_in?
          @vote = Vote.find(params[:id])
          if request.remote_ip != @vote.user_ip && current_user.id != @vote.user_id
            redirect_to root_path
          end
        else
          @vote = Vote.find(params[:id])
          if request.remote_ip != @vote.user_ip
            redirect_to root_path
          end
        end
    end
end
