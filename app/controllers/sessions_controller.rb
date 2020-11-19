class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:saccess] = 'ログインしました。'
      redirect_to tasks_path(@user)
    else
      flash[:danger] = 'ログインに失敗しました。'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
  
  private
  
  def login(email,password)
    @user = User.find_by(email: email)
    if @user = @user.authenticate(password)
      # ログイン成功
      session[:user_id] = @user.id
      return true
      # ログイン失敗
    else
      return false
    end
  end
end
