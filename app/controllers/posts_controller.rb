# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :post_user, except: %i[index show new update create search other_posts]

  def index
    @posts = current_user.posts.page(params[:page]).reverse_order
    @search = current_user.posts.ransack(params[:q])
    @lang = Language.all
    unless params[:q].nil?
      @search_search = current_user.posts.ransack(params[:q])
      @lang = Language.all
      @search = current_user.posts.search(search_params)
      @posts = (@search.result(distinct: true)).page(params[:page]).reverse_order
    end
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
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  def update
    post = Post.find(params[:id])
    if params[:post][:check].nil?
    else
      params[:post][:check].each do |image_id|
        image = post.images.find(image_id)
        image.purge
      end
    end
    post.update(post_params)
    redirect_to post_path(post)
  end

  def other_posts
    @posts = Post.page(params[:page]).reverse_order
    @search = Post.ransack(params[:q])
    @lang = Language.all
    unless params[:q].nil?
      @search_search = current_user.posts.ransack(params[:q])
      @lang = Language.all
      @search = current_user.posts.search(search_params)
      @inu = @search.result(distinct: true)
      @posts = @inu.page(params[:page]).reverse_order
    end
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :language_id, :title, :body, images: [])
  end

  def post_user
    post = Post.find(params[:id])
    if current_user.id != post.user_id
      flash[:notice] = '不正な画面遷移です'
      redirect_to user_path(current_user.id)
    end
  end

  def search_params
    params.require(:q).permit(:title_cont, :body_cont, :language_id_eq, :created_at_gteq, :created_at_lteq)
  end
end
