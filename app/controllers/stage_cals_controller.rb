class StageCalsController < ApplicationController
   before_action :delete_stage_cal, only: [ :create, :delete]
 
 
  def index 
  end
  
  def create
    
     
    @stageCal = StageCal.new
    @stageCal.save
    
    
    redirect_to stage_show_path(params[:room_id])
  end
  
  def delete
    
    redirect_to room_show_path(params[:room_id])
  end
  
  def delete_stage_cal
    
     @stageCal = StageCal.find_by(user_id: current_user.id,  room_id: params[:room_id])
     
     
      @stageCal.destroy
      @stageCal.save
  end
  
end