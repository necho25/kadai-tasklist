class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザー登録が出来ました'
      redirect_to root_path
    else
      flash.now[:danger] = '登録できませんでした。やり直して下さい'
      render :new
    end
  end
  
  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks.order('created_at DESC').page(params[:page])
  end

  def destroy
    
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
