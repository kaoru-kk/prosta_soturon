class PostsController < ApplicationController
  def index
    @posts = current_user.posts.all
  end

  def search
    @posts_search = current_user.posts.where(["title LIKE(?)", "%#{params[:keyword]}%"])
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
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
    post = Post.find(params[:id])
      if params[:post][:check] == nil
      else
        params[:post][:check].each do |image_id|
          image = post.images.find(image_id)
          image.purge
        end
      end
    post.update(post_params)
    redirect_to post_path(post)
  end

  private
  def post_params
    params.require(:post).permit(:user_id, :language_id, :title, :body, images: [])
  end
end
