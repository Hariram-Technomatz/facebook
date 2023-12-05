class PostsController < ApplicationController
  def index
    @users = Friend.accepted.my_friends(current_user) if current_user
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: "Post were successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :content, :image)
  end
end
