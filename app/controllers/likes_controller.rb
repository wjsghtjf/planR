class LikesController < ApplicationController
    
     
#좋아요 부분  
  def toggle
    
    @like = Like.find_by(user_id: current_user.id, room_id: params[:room_id])
    if @like.nil?
      @like = Like.create(user_id: current_user.id, room_id: params[:room_id])
    else
      @like.destroy
    end
    
    @like.save
    
    redirect_to room_show_path(params[:room_id])
    
  end
end
