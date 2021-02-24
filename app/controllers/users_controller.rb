class UsersController < ApplicationController


  def new
    @user = User.new
  end

  def create
      @user = User.new(user_params)
    
      if @user.save
        flash[:seccess] = "ユーザー登録完了"
        redirect_to root_url
      else
        flash.now[:danger] = "ユーザー登録失敗"
        render :new
      end
  end

  private

  # Strong Parameter
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end