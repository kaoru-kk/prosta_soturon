class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end

  def create
    post = Post.new(post_params)

    post.user_id = current_user.id

    post.save
    redirect_to post_path(post)
  end


  def destroy
  end

  def update
  end

  private
  def post_params
    params.require(:post).permit(:user_id, :language_id, :title, :body)
  end
end
