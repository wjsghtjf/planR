class RoomsController < ApplicationController
  before_action :authenticate_user!,   :except => [:index] 
  before_action :find_roomCal, only: [:show, :finish]  
  before_action :find_invites, only: [:team] 
  
   
  def index
  @rooms = Room.all
 
  
  @roomCal = RoomCal.find_by("user_id = ? ", current_user.id)
    
    @dummy=0   # publish_stage_id값이 누적되어쌓임. 해결방안을위한 임시방편..나은방법있음추가요망
    @publish_stage_id=0
    if params[:sort] == "recent"
      @rooms=Room.all
    elsif params[:sort] == "difficulty"
      @rooms=Room.all
    elsif params[:sort] == "like"
      @rooms=Room.all
    else
      @rooms=Room.all
    end
  end
  
  def show
    @room = Room.find(params[:room_id])
   
    @stages = Stage.where("id <= :end_id AND room_id= :room_id", {:end_id => @room.publish_stage_id, :room_id => @room.id})
  end
  
  def team
    @room = Room.find(params[:room_id])
   
  end
  
  
  
  def new
    @rooms=Room.all
  end

  def edit
    
  end
  
  def mine
    @rooms=Room.where('user_id' => current_user.id)
  end
  
    
  def finish
    @room = Room.find(params[:room_id])
  end
    
  #View 가 없는 Controller
    
  def create
    @rooms=Room.all
    @room=Room.new
    @room.title=params[:input_title]
    @room.content=params[:input_content]
    
    if @room.content.length==0
      @room.content="  "
    end
    @room.user_id= current_user.id
    @room.save
    
    redirect_to stage_manage_all_path(@room.id)
  end
  
  def update
    
  end
  
  def delete
    
  end


  def publish
    @room = Room.find(params[:room_id])
    @stage_id = Integer(params[:stage_id])
    if @room.publish_stage_id < @stage_id
      @room.publish_stage_id =  @stage_id
      @room.save
    end
    
    redirect_to room_mine_path
  end
  
#기타 Method

  def room_params
      params.require(:room).permit(:title,:content)
  end
 
  
  def find_invites
    @invites = Invitation.where("room_id = :room_id AND team_id= :team_id", { :room_id => params[:room_id], :team_id => params[:team_id]})
  end
  
  def find_roomCal
   @roomCal = RoomCal.find_by(user_id:  current_user.id, room_id: params[:room_id])
  end
end