class Api::LikesController < ActionController::API
  before_action :authenticate_user!

  def index
    render json: current_user.likes.filter_by_post(params[:post_id]).select(:id, :user_id, :post_id)
  end

  def create
    Like.create!(likes_params.merge(user_id: current_user.id))
    head :created
  end

  def destroy
    Like.find(params[:id]).destroy!
    head :ok
  end
  
  private
  
  def likes_params
    params.require(:like).permit(:post_id)
  end
end
