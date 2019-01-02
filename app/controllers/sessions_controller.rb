class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = 'ログインしました'
      redirect_to @task
    else
      flash.now[:danger] = 'ログイン出来ませんでした'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました'
    redirect_to root_url
  end
  
  private
  
  def login(email, password)
    @task = Task.find_by(email: email)
    if @task && @task.authenticate(password)
      session[:user.id] = @task.id
      return true
    else
      return false
    end
  end
end
