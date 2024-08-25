class Admin::PostsController < ApplicationController
  
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end
  
private
  
  def post_params
    params.require(:post).permit(:image, :title, :shop_name, :recommend_point, :advice, :prefecture, :address, :block)
  end
end
