class PostsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_post, only: [:show, :edit, :update, :destroy]
  def index
    @user = User.all.where.not( :id => current_user.id )
    @posts = Post.where("user_id IN (?)", current_user.friends.pluck(:id))
    @post = Post.new
  end
  
  def add_friends
      @friends = Friend.create(:user_id => params[:friend][:id])
      redirect_to '/'
  end

  def user_list
      @users = User.all
  end
  def show
  end
 
  def new
    @post = Post.new
  end
 
  def edit
  end
 
  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to posts_path
    else
      render 'new'
    end
  end
 
  def update
 
    if @post.update(post_params)
      redirect_to posts_path
    else
      render 'edit'
    end
  end
 
  def destroy
    @post.destroy
 
    redirect_to posts_path
  end
 
  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:text , :user_id)
    end
end

