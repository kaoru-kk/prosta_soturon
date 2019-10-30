class FavoritesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    fav = current_user.favorites.new(post_id: post.id)
    fav.save
    redirect_to post_path(post.id)
  end

  def destroy
    post = Post.find(params[:post_id])
    fav = current_user.favorites.find_by(post_id: post.id)
    fav.destroy
    redirect_to post_path(post.id)
  end
end
