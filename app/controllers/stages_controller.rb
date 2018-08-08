class StagesController < ApplicationController
  
  before_action :set_stage, only: [:update, :delete, :check]
  before_action :find_roomCal, only: [:show, :check, :hintpage]
  before_action :get_chats, only: [:show ]
  
  # View가 있는 Controller
  
  def show
   
    @room=Room.find(params[:room_id]) 
    @stages = Stage.where("id <= :end_id AND room_id= :room_id", {:end_id => @room.publish_stage_id, :room_id => @room.id})
     
    @stage_level = 0
    
    if params[:stage_level]
      @stage_level= Integer(params[:stage_level])
      puts "Stage/show : stage_level = #{@stage_level} from parameter"
      # URL로 감히 다음 스테이지를 보려고 한 경우, last_stage_level로 stage_level를 바꿔버린다.
      if @roomCal.last_stage_level < @stage_level
        puts "#{current_user.id}, #{current_user.email} 님께서 비정상적인 접근을 시도했습니다."
        @stage_level=@roomCal.last_stage_level
      end
    elsif @roomCal
      @stage_level = @roomCal.last_stage_level
      puts "Stage/show : stage_level = #{@stage_level} from roomCal"
    end
     if  @stage_level >= @stages.length && @stages.length>0
        @stage_level=@stages.length
        @wait_for_update = true
        
      puts "Stage/show : 업데이트 대기 상태 @stage_level = #{@stage_level}"
      end
      
    @stage=nil
    
    @stages.each_with_index do |s, index|
      if index == @stage_level
        @stage=s
        puts "Stage/show : @stage = #{@stage}"
        break
      end
    end
    
    
    if @stage == nil
      
      if @wait_for_update == true
        puts "Stage/show : @stage가 nil이지만 업데이트 대기 상태이므로 @stage = #{@stages.last}"
        @stage=@stages.last
      else
        puts "Stage/show : @stage가 nill이다"
        
        redirect_to room_show_path(params[:room_id])
      end
    end
    
  end

 
  
  def manage
    
    @room=Room.find(params[:room_id])
    puts "Stage/manage : @room = #{@room}"
    # 스테이지 목록을 위한 stage의 배열
    @stages = Stage.where('room_id' => @room.id)
    
    puts "Stage/manage : @stages = #{@stages}"
    
    #stage는 우측 화면에 정보를 보여줄 Stage 객체이다.
      
      
    #parameter 중에서 stage_id가 있는 경우
    if params[:stage_id] 
      # stage_id에 해당하는 stage를 가져온다.
      @stage = Stage.find(params[:stage_id])
      puts "Stage/manage : @stage = #{@stage} from parameter"
    # stage배열이 한개 이상일 경우 stage 배열에서 가장 마지막 stage를 화면에 띄어준다.
    else @stages.length!=0
        @stage = @stages.last
      puts "Stage/manage : @stage = #{@stage} from last"
    end
    
    #parameter 중에서 edit_mode가 있는 경우 @edit_mode를 참으로 설정한다.
    if params[:edit_mode]
      @edit_mode=true
    else
      @edit_mode=false
    end
    puts "Stage/manage : @edit_mode = #{@edit_mode}"
    
    # 선택된 stage가 있으면서 선택된 스테이지의 image_url이 있는 경우 @stage_file_name에 파일명을 저장시킨다.
    # 수정모드에서 업로드 되있는 파일을 보여주기 위해서 사용 된다.
    if @stage && @stage.image.url
      @stage_file_name = @stage.image.url.split('/')[-1]
      puts "Stage/manage : @stage_file_name = #{@stage_file_name}"
    else
      @stage_file_name = ""
    end
    
    
  end
  
    
    #View 가 없는 Controller
    
 
  def create
    # 스테이지의 경우 room_id만 가지고 객체를 만든후에 사용자가 입력한 후에 저장을 하면 update가 된다.
    @stage = Stage.new
    @stage.room_id=params[:room_id]
    @stage.save
    
    # 새로 만들어진 stage는 edit_mode로 redirect해준다.
    redirect_to stage_manage_each_path(@stage.room_id,@stage.id, edit_mode: true)
  end
  
  def update
    
    
    # 파라미터중에 is_delete_origin_image 가 있을 경우에는 디비에 저장된 이미지 파일을 삭제한다.
    if params[:is_delete_origin_image] 
      @stage.remove_image!
    end
    
    # stage에 관련된 파라미터로 내용을 업데이트한다.
    @stage.update(stage_params)
  
    @stage.save
    redirect_to stage_manage_each_path(@stage.room_id,@stage.id)
  end
  
  def delete
    @stage.destroy
    @stage.save
    
    redirect_to stage_manage_all_path(@stage.room_id)
  end
  
  # def usehint
  #   @hintCal = RoomCal.find_by("user_id = ? AND room_id=?", current_user.id, params[:room_id])
  #   @hintCal.usedhint = (@hintCal.usedhint + 1)
  #   @hintCal.save
    
  # end

  def hintpage
    @room = Room.find(params[:room_id])
    @stages = Stage.where('room_id' => @room.id)
    @hintlist = Stage.new
    @hint_num = params[:hint_num]
    
    @stages.each do |s|
      if Integer(params[:stages_id]) == s.id
        @hintlist = s
        @hintlist.save
      end
    end

    @roomCal.usedhint = (@roomCal.usedhint) + 1
    @roomCal.save
    
    
    # @hintlist = Stage.find_by("room_id = ? AND stages_id = ?", params[:room_id], params[:stages_id])
    # @hintlist.save

  end

  def check
    @stage_level = Integer(params[:stage_level])
    # @hintCal = RoomCal.find_by("user_id = ? AND room_id=?", current_user.id, params[:room_id])
    # before_action으로 @roomCal에 값 가져옵니당

   
    
    @is_wrong_answer=true
    
    if @stage.answer == params[:enter_answer]
      
      puts "Stage/check : 정답"
      
      
      @roomCal.last_stage_level = (@roomCal.last_stage_level + 1)
      @roomCal.save
      @stage_level = 1 +  Integer(params[:stage_level])
      @is_wrong_answer=false
      
      if @roomCal.usedhint == 1
        User.find(current_user.id).rank_point += 0.007
      elsif @roomCal.usedhint == 2
         User.find(current_user.id).rank_point += 0.004
      elsif @roomCal.usedhint == 3
         User.find(current_user.id).rank_point += 0.001
      else
         User.find(current_user.id).rank_point += 0.01
      end 
     
      @roomCal.usedhint = 0
      @roomCal.save
       
    else
      if @roomCal.last_stage_level == @stage_level
        @roomCal.try = @roomCal.try + 1
        @roomCal.save
        puts "Stage/check : 오답, try 1증가  -> #{@roomCal.try}"
      else
        puts "Stage/check : 오답, 이미 푼 문제"
      end
      
    end
    
  end
#기타 Method

  def set_stage
    @stage = Stage.find(params[:stage_id])
  end

  def stage_params
      params.require(:stage).permit(:title,:content,:hint1,:hint2,:hint3,:image,:answer)
  end
  
  
  def find_roomCal
  
    @roomCal = RoomCal.find_by(user_id: current_user.id, room_id: params[:room_id])
   
  end
  
  def get_chats
    @chats = Chat.where("team_id == :team_id", {:team_id => @roomCal.team_id})
    
    @userMap = Hash.new
    
    @chats.each do |c|
      if @userMap[c.user_id]==nil
        @user = User.find(c.user_id)
        @userMap[c.user_id] =@user.nickname
      end
    end
    
  end
end