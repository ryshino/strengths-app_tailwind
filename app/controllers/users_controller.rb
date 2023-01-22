class UsersController < ApplicationController
  def new
    @user = User.new  
  end

  def create
    @user = User.new(user_params)
    # @user.profile_icon.attach(params[:user][:profile_icon])
    if @user.save
      flash[:success] = "ユーザー登録に成功しました"
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    # adminを含んでいないのは任意のユーザーが
    # 自分自身にアプリケーションの管理者権限を与えることを防止するため
    params.require(:user).permit(:name, :profile, :password,
                                :password_confirmation, :profile_icon)
  end
end
