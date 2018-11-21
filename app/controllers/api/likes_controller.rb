class Api::LikesController < ActionController::API
  before_action :authenticate_user!

  def index
    favorite_courses = current_user.likes
    render json: favorite_courses
  end

  def create
    Like.create!(likes_params)
    head :created
  end

  def destroy
    Like.find(params[:id]).destroy!
    head :ok
  end
  
  private
  
  def likes_params
    params.require(:likes).permit(:post_id, :user_id)
  end
end
