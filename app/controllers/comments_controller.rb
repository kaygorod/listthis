class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :correct_user,       only: :destroy

  def create
    @list = List.find(params[:list_id])
    @comment = @list.comments.build(comment_params)
    @comment.user_id = current_user.id
    @item = Item.find_by_id(@comment.item_id)
    if @comment.save
      respond_to do |format|
        format.html { redirect_to @list}
        format.json { head :no_content }
        format.js
      end
    else
      flash[:danger] = 'Ой! Что-то пошло не так...'
      redirect_to @list
    end
  end

  def destroy
    @list = List.find(params[:list_id])
    @comment = Comment.find(params[:id])
    @item = Item.find_by_id(@comment.item_id)
    if @comment.present?
       @comment.destroy
    end
    respond_to do |format|
      format.html { redirect_to @list, notice: 'Комментарий удален!' }
      format.json { head :no_content }
      format.js   { render layout: false }
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :item_id)
    end

    def correct_user
      @comment = current_user.comments.find(params[:id])
      redirect_to root_path if @comment.nil?
    end

end
