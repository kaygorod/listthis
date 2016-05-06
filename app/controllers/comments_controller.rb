class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :correct_user,       only: :destroy

  def create
    @list = List.find(params[:list_id])
    @comment = @list.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = 'Комментарий отправлен!'
      redirect_to @list
    else
      flash[:danger] = 'Ой! Что-то пошло не так...'
      redirect_to @list
    end
  end

  def destroy
    @list = List.find(params[:list_id])
    @comment = Comment.find(params[:id])
    if @comment.present?
       @comment.destroy
    end
    flash[:success] = 'Комментарий удален!'
    redirect_to @list
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
