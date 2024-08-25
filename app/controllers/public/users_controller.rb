class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]

  def index
    @users = User.all
  end
  
  def mypage
    @user = current_user
    @posts = @user.posts
    @following_users = @user.following_users
    @follower_users = @user.follower_users
    
    render :show
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @following_users = @user.following_users
    @follower_users = @user.follower_users
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = '登録内容を変更しました。'
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

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  def follows
    user = User.find(params[:id])
    @users = user.following_users
  end

  def followers
    user = User.find(params[:id])
    @user = user.follower_users
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
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
     redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集できません。"
    end
  end
end
