class Public::PostsController < ApplicationController
before_action :authenticate_user!, except: [:show, :index]
before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = '投稿に成功しました。'
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
    if @post.update(post_params)
     redirect_to post_path
    else
      render :edit
    end
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:notice] = '投稿を削除しました。'
    redirect_to mypage_path
  end
  
  def feed
    follow_users = Relationship.where(follower_id: current_user.id)
    @posts = Post.where(user_id: follow_users.pluck(:followed_id)).order(created_at:"DESC").all
  end
  
private
  
  def post_params
    params.require(:post).permit(:image, :title, :shop_name, :recommend_point, :advice, :prefecture, :address, :block)
  end
  
  def is_matching_login_user
    post = Post.find_by(id: params[:id])
    if post.nil?
      redirect_to posts_path
    elsif current_user && post.user_id != current_user.id
      redirect_to posts_path
    end
  end
end