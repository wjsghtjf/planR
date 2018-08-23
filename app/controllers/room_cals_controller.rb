class RoomCalsController < ApplicationController
  before_action :delete_room_cal, only: [ :create, :delete]
  before_action :find_user, only: [:create]
  before_action :find_invites, only: [:create_invited]
  
  def index 
  end
  
  def create_invited
    @roomCal = RoomCal.new
    @roomCal.user_id = current_user.id
    
    
    @roomCal.room_id = Integer(params[:room_id])
    @roomCal.team_id = Invitation.find_by(user_id: current_user.id,  room_id: @roomCal.room_id).team_id
    @roomCal.last_stage_level = 0
    
    @roomCal.mode = 0
    @roomCal.save
    
    redirect_to post_notification_path
  end
  
  
  def create
    
    @roomCal = RoomCal.new
    @roomCal.user_id = current_user.id
    @roomCal.room_id = Integer(params[:room_id])
    @roomCal.last_stage_level=0
    
    if Integer(params[:mode]) == 1  #싱글모드
      @roomCal.mode = 1 #싱글플레이
      @roomCal.save
      @user.award_single = @user.award_single + 1
      @user.save
      
      redirect_to stage_show_path(params[:room_id])
    elsif Integer(params[:mode]) == 2    #멀티플레이모드
      @roomCal.mode = 5 #멀티플레이 대기상태로 전환
      # @roomCal.team_id= Integer(params[:team_id])
      @roomCal.save
      # @user.award_multi = @user.award_multi + 1
      
      
    end
  end
  
  def delete
    
    redirect_to room_show_path(params[:room_id])
  end
  
  def delete_room_cal
    
    @roomCal = RoomCal.find_by(user_id: current_user.id,  room_id: params[:room_id])
     
    if @roomCal 
        if @roomCal.team_id && RoomCal.where("team_id= :team_id", {:team_id => @roomCal.team_id}).size > 0
          @team =Team.find(@roomCal.team_id) 
          @team.destroy
          @team.save
        end
        @roomCal.destroy
        @roomCal.save
    end
  end
  
  def find_user
    @user = User.find(current_user.id)
  end
  
  def find_invites
    @invites = current_user.invitations
  end
end
