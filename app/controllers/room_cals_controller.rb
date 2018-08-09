class RoomCalsController < ApplicationController
  before_action :delete_room_cal, only: [ :create, :delete]
  def index 
  end
  
  def create
    
     
    @roomCal = RoomCal.new
    @roomCal.user_id = current_user.id
    @roomCal.room_id = Integer(params[:room_id])
    @roomCal.last_stage_level=0
    
    if params[:mode].nil?      #싱글모드
      @roomCal.mode = 1 #싱글플레이
      
    else   #멀티플레이모드
      @roomCal.mode = 2 #멀티플레이 
      @roomCal.team_id= Integer(params[:team_id])
    end
        
    @roomCal.save
    
    
    
    
  
    
    redirect_to stage_show_path(params[:room_id])
  end
  
  def delete
    
    redirect_to room_show_path(params[:room_id])
  end
  
  def delete_room_cal
    
     @roomCal = RoomCal.find_by(user_id: current_user.id,  room_id: params[:room_id])
     if !@roomCal.nil?
       if !@roomCal.team_id.nil? 
        @team =Team.find(@roomCal.team_id)
        @team.destroy
        @team.save
      end
      @roomCal.destroy
      @roomCal.save
    end
  end
end
