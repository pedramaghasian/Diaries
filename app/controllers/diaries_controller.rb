class DiariesController < ApplicationController

  def index
    @diaries=Diary.all
  end

  def show 
    @diary=Diary.find(params[:id])
  end

  def new 
    @diary=Diary.new 
  end

  def create 
    @diary=Diary.new(diary_params)
    @diary.user=User.first
    if @diary.save 
      flash[:success]="Diary was created successfully !"
      redirect_to diary_path(@diary)
    else  
      render 'new'
    end
  end

  def edit 
    @diary=Diary.find(params[:id])
  end

  def update 
    @diary=Diary.find(params[:id])
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

  def diary_params
    params.require(:diary).permit(:name , :description)
  end



end