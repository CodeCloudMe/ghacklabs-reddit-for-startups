class PostsController < ApplicationController
  def index
    # Sorted by popularity
    @posts = Post.visible_to(current_user).where("posts.created_at > ?",7.days.ago).paginate(page: params[:page], per_page: 10)
    authorize @posts
  end
end
