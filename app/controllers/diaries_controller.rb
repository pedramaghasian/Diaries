class DiariesController < ApplicationController

  before_action :set_diary , only: [:show , :edit , :update,:destroy]

  before_action :require_user , except: [:index,:show]
  
  before_action :require_same_user,only: [:edit,:update,:destroy]

  def index
    @diaries=Diary.paginate(page: params[:page],per_page: 5)
  end

  def show 
    # @diary=Diary.find(params[:id])
    @comment=Comment.new
    @comments=@diary.comments.paginate(page: params[:page],per_page: 5)
  end

  def new 
    @diary=Diary.new 
  end

  def create 
    @diary=Diary.new(diary_params)
    @diary.user = current_user
    if @diary.save
      flash[:success]="Diary was created successfully !"
      redirect_to diary_path(@diary)
    else  
      render 'new'
    end
  end

  def edit 
    # @diary=Diary.find(params[:id])
  end

  def update 
    # @diary=Diary.find(params[:id])
    if @diary.update(diary_params)
      flash[:success]= "Diary was updates successfully !"
      redirect_to diary_path(@diary)
    else  
      render 'edit'
    end
  end

  def destroy 
    Diary.find(params[:id]).destroy  
    flash[:success]=" Diary deleted successfully !"
    redirect_to diaries_path
  end


  private

  def set_diary
    @diary=Diary.find(params[:id])
  end

  def diary_params
    params.require(:diary).permit(:name , :description)
  end

  def require_same_user
    if current_user != @diary.user and !current_user.adminstrator?
      flash[:danger]= " You only can Edit or Delete your own recipe !!!"
      redirect_to diaries_path
    end
  end

end