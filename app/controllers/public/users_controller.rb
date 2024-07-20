class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id]) 
    @user.destroy
    flash[:notice] = 'ユーザーを削除しました。'
    redirect_to new_user_registration_path
  end
  
private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image)
  end
  
  def is_matching_login_user
    user = User.find_by(id: params[:id])
    if user.nil?
      redirect_to user_path(user.id)
    elsif user.id != current_user.id
      redirect_to user_path(user.id)
    end
  end
  
  def ensure_guest_user
    if current_user.guest_user?
     redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集できません。"
    end
  end
end