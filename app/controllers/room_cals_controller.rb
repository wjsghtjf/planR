class RoomCalsController < ApplicationController
    
  def index 
  end
  
  def create
     
    @roomCal = RoomCal.new
    @roomCal.user_id = current_user.id
    @roomCal.room_id = Integer(params[:room_id])
    @roomCal.last_stage_level=0
    @roomCal.save
    puts "Stage/find_roomCal : RoomCal이 없는 경우, 새로 만든다. @roomCal = #{@roomCal}"
    
    if @roomCal.team_id == nil
      @team = Team.new
      @team.save
      @roomCal.team_id = @team.id  
      @roomCal.save
      puts "Stage/find_roomCal : RoomCal에 team_id가 없는 경우 새로 Team을 만들어서 부여해준다. @team=#{@team}"
    end
    
    redirect_to stage_show_path(params[:room_id])
  end
  
  
  def update
     @roomCal = RoomCal.find_by("user_id = ? AND room_id=?", current_user.id, params[:room_id])
    if @roomCal == nil
      
      @roomCal = RoomCal.new
      @roomCal.user_id = current_user.id
      @roomCal.room_id = Integer(params[:room_id])
      @roomCal.last_stage_level=0
      @roomCal.save
      puts "Stage/find_roomCal : RoomCal이 없는 경우, 새로 만든다. @roomCal = #{@roomCal}"
    end
    
    if @roomCal.team_id == nil
      @team = Team.new
      @team.save
      @roomCal.team_id = @team.id  
      @roomCal.save
      puts "Stage/find_roomCal : RoomCal에 team_id가 없는 경우 새로 Team을 만들어서 부여해준다. @team=#{@team}"
    end
  end
end
