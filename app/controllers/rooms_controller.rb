class RoomsController < ApplicationController
  before_action :authenticate_user!,   :except => [:index] 
  before_action :find_user, only: [:publish, :confirm, :delete]
  before_action :find_room, only: [:show, :update, :finish, :publish, :team, :delete ]
  before_action :find_roomCal, only: [:show, :finish, :team]  
  before_action :find_invites, only: [:team, :confirm] 
  
  
   
  def index
    @rooms = Room.all

    # @roomCal = RoomCal.find_by("user_id = ? ", current_user.id)
    
    
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
   
    @stages = Stage.where("id <= :end_id AND room_id= :room_id", {:end_id => @room.publish_stage_id, :room_id => @room.id})
    @team = Team.find_by(user_id: current_user.id, room_id: params[:room_id])
  end
  
  def team
    @roomCal.team_id= params[:team_id]
    @roomCal.save
  end
  
  def confirm
    @team = Team.find(params[:team_id])
    @room_cals = RoomCal.where('team_id' => @team.id)
    @room_cals.each do |room_cal|
      room_cal.mode = 2
      room_cal.save
    end

    @user.award_multi = @user.award_multi + 1
    @user.save
    
    redirect_to stage_show_path(params[:room_id])
  end
  
  def new
  end

  def edit
    
  end
  
  def mine
    @rooms=Room.where('user_id' => current_user.id)
  end
  
    
  def finish
    @room=Room.find(params[:room_id])
  end
    
  #View 가 없는 Controller
    
  def create
    @room=Room.new(room_params)
    if @room.content.length==0
      @room.content="  "
    end
    @room.user_id= current_user.id
    @room.save
    
    redirect_to stage_manage_all_path(@room.id)
  end
  

  
  def update
    
    # 파라미터중에 is_delete_origin_image 가 있을 경우에는 디비에 저장된 이미지 파일을 삭제한다.
    if params[:is_delete_origin_image]=="true"
      @room.remove_image!
    end
    
    if params[:room][:image]
      @room.update(room_params)
    else
      @room.update(room_params_without_image)
    end
    
    redirect_to stage_manage_each_path(@room.id,0) 
  end
  
  def delete
    @rooms=@user.rooms
    @rooms.each do |room|
      if room.id==params[:room_id]
        room.destroy
      end
    end
   
    
    redirect_to room_mine_path
  end

  

  def publish
    @stage_id = Integer(params[:stage_id])
    if @room.publish_stage_id < @stage_id
      @room.publish_stage_id =  @stage_id
      @room.save
    end
    
    @user.award_distribute = @user.award_distribute + 1
    @user.save
    
    redirect_to room_mine_path
  end
  
#기타 Method

  def find_user
    @user = User.find(current_user.id)
  end
  
  def find_invites
    @invites = Invitation.where("room_id = :room_id AND team_id= :team_id", { :room_id => params[:room_id], :team_id => params[:team_id]})
  end
  
  def find_roomCal
   @roomCal = RoomCal.find_by(user_id:  current_user.id, room_id: params[:room_id])
  end
  
  def find_room
    @room = Room.find(params[:room_id])
  end
  
  def room_params
      params.require(:room).permit(:title,:content,:image)
  end
  
  
  def room_params_without_image
      params.require(:room).permit(:title,:content)
  end
end