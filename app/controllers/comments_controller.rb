class CommentsController < ApplicationController 
  before_action :require_user

  def create 
    
    @diary = Diary.find(params[:diary_id])
    @comment=@diary.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      # ActionCable.server.broadcast 'comments_channel', render(partial: 'comments/comment',object: @comment)
      flash[:success]="#{@comment.user.name} your comment created successfully !"
      redirect_to diary_path(@diary)
    else 
      flash[:danger]=" Your comment NOT create #{@comment.user.name} !"
      redirect_back fallback_location: 'diaries/show'
    end
  end

  def comment_params 
    params.require(:comment).permit(:description)
  end
end