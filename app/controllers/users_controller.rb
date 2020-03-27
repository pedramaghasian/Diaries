class UsersController < ApplicationController 
  before_action :set_diary , only: [:show , :edit , :update,:destroy]
  before_action :require_same_user , only: [ :edit, :update,:destroy]
  before_action :require_admin , only: [:destroy]

  def index 
    @users=User.paginate(page: params[:page],per_page: 5)
  end

  def new 
    @user=User.new
  end

  def create 
    @user=User.new(user_params)
    if @user.save 
      session[:user_id]=@user.id
      cookies.signed[:user_id]=@user.id
      flash[:success]="Welcome #{@user.name} to my diary App !"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def show  
    # @user=User.find(params[:id])
    @user_diaries=@user.diaries.paginate(page: params[:page],per_page: 5)
  end

  def edit  
    # @user=User.find(params[:id])
  end
  
  def update
    # @user=User.find(params[:id])
    if @user.update(user_params)
      flash[:success]="Your Diary was updated successfully !"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def destroy
    if !@user.adminstrator?
      # @user=User.find(params[:id])
      @user.destroy
      flash[:danger]="user and all associate diaries was deleted !"
      redirect_to users_path
    end

  end
  private
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

  def set_diary
    @user=User.find(params[:id])
  end

  def require_same_user
    if current_user != @user and !current_user.adminstrator?
      flash[:danger]="you can only Edite or Delete your own account !!!"
      redirect_to users_path
    end
  end

  def require_admin
    if logged_in? && !current_user.adminstrator?
      flash[:danger]="Only admin can do that !"
      redirect_to root_path
    end
  end
end