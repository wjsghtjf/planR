class RoomsController < ApplicationController
  before_action :authenticate_user!,   :except => [:index] 
  before_action :find_roomCals, only: [:show, :finish] 
  before_action :find_invites, only: [:team] 
   # View가 있는 Controller
   
  def index
  @rooms = Room.all
  @likecount = Room.new
  
  @rooms.each do |like|
    @likecount = like.likes
  end
  
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
   
   if @roomCal == nil
    @roomCal=RoomCal.new
    @roomCal.room_id=params[:room_id]
    @roomCal.user_id=current_user.id
    
    @team = Team.new
    @team.save
    @roomCal.team_id = @team.id
    
    @roomCal.save
  end
  if @roomCal.team_id == nil
    @team = Team.new
    @team.save
    @roomCal.team_id = @team.id
    @roomCal.save
    
  end
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
    @rooms=Room.where('master_id' => current_user.id)
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
    @room.master_id= current_user.id
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
  
#좋아요 부분  
  def like
    
  @rooms = Room.all
       @roomCal = RoomCal.find_by("user_id = ? ", current_user.id)
  
  @rooms.each do |like|
        if @roomCal.like.nil?
      @roomCal.like = (@roomCal.like)+1
      @likes = Room.find(params[:room_id])
      @likes = (@likes)+1
    else
      @roomCal.like = (@roomCal.like)-1
      @likes = Room.find(params[:room_id])
      @likes = (@likes)-1
    end
    
    redirect_to :back
  end
    

    # if @roomCal.like.nil?
    #   @roomCal.like = (@roomCal.like)+1
    #   @likes = Room.find(params[:room_id])
    #   @likes = (@likes)+1
    # else
    #   @roomCal.like = (@roomCal.like)-1
    #   @likes = Room.find(params[:room_id])
    #   @likes = (@likes)-1
    # end
    
    # redirect_to :back
  end
  
  def find_invites
    @invites = Invitation.where("room_id = :room_id AND team_id= :team_id", { :room_id => params[:room_id], :team_id => params[:team_id]})
    
  end
  
  def find_roomCals
   @roomCal = RoomCal.find_by("user_id = ? AND room_id=?", current_user.id, params[:room_id])
  end
end