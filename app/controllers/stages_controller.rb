class StagesController < ApplicationController
  
  before_action :find_user, only: [:check, :show, :create, :delete, :manage, :hintpage_item]
  before_action :find_room, only: [:show, :manage, :hintpage,:check]
  before_action :find_stages, only: [:show,:check]
  before_action :find_stage, only: [:update, :delete, :check]
  before_action :find_roomCal, only: [:show, :check, :hintpage, :hintpage_item]
  before_action :find_stageCal, only: [:hintpage, :hintpage_item, :check]
  before_action :get_chats, only: [:show]
  
  # View가 있는 Controller
  
  def show
     @stage_level = 0
    
    if params[:stage_level]
       @stage_level= Integer(params[:stage_level])
      #puts "Stage/show : stage_level = #{@stage_level} from parameter"
      # URL로 감히 다음 스테이지를 보려고 한 경우, last_stage_level로 stage_level를 바꿔버린다.
      if @roomCal.last_stage_level < @stage_level
        #puts "#{current_user.id}, #{current_user.email} 님께서 비정상적인 접근을 시도했습니다."
        @stage_level=@roomCal.last_stage_level
      end
    elsif @roomCal
      @stage_level = @roomCal.last_stage_level
      #puts "Stage/show : stage_level = #{@stage_level} from roomCal"
    end
    
    if @stages[@stage_level - 1].laststage == 1 && @stage_level >= @stages.length
      @stage_level = @stages.length
      @wait_for_finish = true
      @room.clearcount = @room.clearcount + 1
      @room.save
    elsif @stages[@stage_level - 1].laststage == 0 && @stage_level >= @stages.length
      @stage_level=@stages.length
      @wait_for_update = true
    end
    
  
    
    # if @stage_level >= @stages.length
    #   @stage_level = @stages.length
    #   @wait_for_finish = true
    #   @room.clearcount = @room.clearcount + 1
    #   @room.save
      
    # elsif  @stage_level >= @stages.length && @stages.length>0
    #     @stage_level=@stages.length
    #     @wait_for_update = true
        
    #   puts "Stage/show : 업데이트 대기 상태 @stage_level = #{@stage_level}"
    # end
      
    @stage = nil
    
    
    
    @stage = @stages[@stage_level]
    
    
    if @stage == nil
      
      if @wait_for_update == true
        #puts "Stage/show : @stage가 nil이지만 업데이트 대기 상태이므로 @stage = #{@stages.last}"
        @stage=@stages.last
      
#여기부터 완료처리 시퀀스
      elsif @wait_for_finish == true
      
        @user.award_clear = @user.award_clear + 1
        @user.save
        
        ## [랭킹] 룸클리어 보너스 부분
        if(@roomCal.mode == 1 || @roomCal.mode == 2)
          if(@room.clearcount > 5)
            @plus = (Float(@stage_level)*(@room.difficulty)/Float(200))*10
            
            if(@user.rank_point >= 9.00)
              @user.rank_point = @user.rank_point + (Float(@plus)*0.4)
            elsif(@user.rank_point >= 6.00)
              @user.rank_point = @user.rank_point + (Float(@plus)*0.6)
            elsif(@user.rank_point >= 3.00)
              @user.rank_point = @user.rank_point + (Float(@plus)*0.8)
            else
              @user.rank_point = @user.rank_point + Float(@plus)
            end
            @user.save
          else
            @plus = (Float(@stage_level)*0.30/Float(20))*10
            
            #등급 페널티
            if(@user.rank_point >= 9.00)
              @user.rank_point = @user.rank_point + (Float(@plus)*0.4)
            elsif(@user.rank_point >= 6.00)
              @user.rank_point = @user.rank_point + (Float(@plus)*0.6)
            elsif(@user.rank_point >= 3.00)
              @user.rank_point = @user.rank_point + (Float(@plus)*0.8)
            else
              @user.rank_point = @user.rank_point + Float(@plus)
            end
            @user.save
          end
        end
      
        ## [모드조정] 진행중 상태 -> 완료 상태로 변경
        if(@roomCal.mode == 1)
          @roomCal.mode = 3
        elsif(@roomCal.mode == 2)
          @roomCal.mode = 4
        end
        @roomCal.save
      
        redirect_to room_finish_path(params[:room_id])
##여기까지 완료처리 시퀀스
      
      else
        #puts "Stage/show : @stage가 nill이다"
        
        redirect_to room_show_path(params[:room_id])
      end
        
    else
      set_stageCal()
      
    end
    if @stage && @stage.mode == 4
      getAnserInfoImageTheme(@stage)
    end
  end

 
  
  def manage
    @stages = Stage.where('room_id' => @room.id)
    
    if params[:stage_level] 
      @stage_level = [Integer(params[:stage_level]), @stages.length ].min
    else
      @stage_level = @stages.length
    end
    @stage = @stages[@stage_level - 1] if @stage_level > 0
    
    #puts "Stage/manage : @stage = #{@stage} with Stage_level : #{@stage_level}"
    #parameter 중에서 edit_mode가 있는 경우 @edit_mode를 참으로 설정한다.
    
    @edit_mode = params[:edit_mode].to_s == "true"
    
    if params[:edit_mode] == "true"
      @user.award_edit = @user.award_edit + 1
      @user.save
    end
    #puts "Stage/manage : @edit_mode = #{@edit_mode}"
    
    # 선택된 stage가 있으면서 선택된 스테이지의 image_url이 있는 경우 @stage_file_name에 파일명을 저장시킨다.
    # 수정모드에서 업로드 되있는 파일을 보여주기 위해서 사용 된다.
    if @stage && @stage.image.url
      @stage_file_name = @stage.image.url.split('/')[-1]
      puts "Stage/manage : @stage_file_name = #{@stage_file_name}"
    else
      @stage_file_name = ""
    end
    
    if  @room.image.url
      @room_file_name = @room.image.url.split('/')[-1]
      #puts "Stage/manage : @room_file_name = #{@room_file_name}"
    else
      @room_file_name = ""
    end
    
    if @stage && @stage.mode == 4
      getAnserInfoImageTheme(@stage)
    end
    
  end
  
    
    #View 가 없는 Controller
    
 
  def create
    # 스테이지의 경우 room_id만 가지고 객체를 만든후에 사용자가 입력한 후에 저장을 하면 update가 된다.
    @stage = Stage.new
    @stage.room_id=params[:room_id]
    @stage.save
    @user.award_make = @user.award_make + 1
    @user.save
    
    redirect_to stage_manage_all_path(params[:room_id], edit_mode: true)
  end
  
  def update

    
    @stage.laststage = Integer(params[:last_check])  if params[:last_check]
     $dial_mode_num[Integer(params[:stage_level])-1]=Integer(params[:dial_check]) if params[:dial_check]==0
  
    
    if params[:is_delete_origin_image]=="true"
      @stage.remove_image!
    end
    
    
    if params[:stage][:image]
      @stage.update(stage_params)
    else 
      @stage.update(stage_params_without_image)
    end

  
    @stage.save
    redirect_to stage_manage_each_path(@stage.room_id,params[:stage_level])
  end
  
  def delete
    @stage.destroy
    @stage.save
    @user.award_delete = @user.award_delete + 1
    @user.save
    
    redirect_to stage_manage_all_path(@stage.room_id)
  end
  

  def hintpage

    @hint_num = params[:hint_num]
    
    if Integer(@hint_num) == 1
      @stageCal.usedhint1 = 1
    elsif Integer(@hint_num) == 2
      @stageCal.usedhint2 = 1
    elsif Integer(@hint_num) == 3
      @stageCal.usedhint3 = 1
    end
    
    @stageCal.save
    
    @hintlist = Stage.find(params[:stage_id])
  end
  
  def hintpage_item
    @hint_num = params[:hint_num]
    
    if Integer(@hint_num) == 1
      @stageCal.usedhint1 = 1
      @stageCal.useditem = @stageCal.useditem + 1
      @user.item_freehint = @user.item_freehint - 1
    elsif Integer(@hint_num) == 2
      @stageCal.usedhint2 = 1
      @stageCal.useditem = @stageCal.useditem + 1
      @user.item_freehint = @user.item_freehint - 1
    elsif Integer(@hint_num) == 3
      @stageCal.usedhint3 = 1
      @stageCal.useditem = @stageCal.useditem + 1
      @user.item_freehint = @user.item_freehint - 1
    end
    
    @stageCal.save
    @user.save
    
    @hintlist = Stage.find(params[:stage_id])
  end

  def check

    @stage_level = Integer(params[:stage_level])
    @input_ans= params[:stage_answer]
    @input_ans= @input_ans.gsub(/\s+/, "").downcase
    
    @is_wrong_answer=true
    @mode3_Ans=0
      
    if @stage.mode==3
      @Ans= @stage.answer.split(",").map { |s| s.to_i }.sort.uniq
      @Ans_com=params[:stage_answer].split(",").map { |s| s.to_i }.sort.uniq
      
      if @Ans==@Ans_com
        @mode3_Ans=1
      end
    end    
    
    if @stage.mode== 0
      @Ans_arr=[@stage.answer,@stage.answer2,@stage.answer3]
      @Ans_com1=params[:stage_answer]
      @mode3_Ans=0
      for i in 0..2 do
           if @Ans_arr[i]==@Ans_com1
             @mode3_Ans=1
           end   
      
      end
      
    end
    
    if @stage.mode == 2
      @Ans_com2=params[:stage_answer]
      @Ans2=@stage.answer
      @mode2_Ans=0
      if @Ans_com2==@Ans2
        @mode2_Ans=1
      end
    end
    
    if checkAnswer(@stage, @input_ans) 
      
      #puts "Stage/check : 정답"
      
      @roomCal.last_stage_level = (@roomCal.last_stage_level + 1)
      @roomCal.save
      @stage.pass = @stage.pass + 1
      @stage.try = @stage.try + 1
      if @stage.mode == 3
        @stageCal.selection_try = @stageCal.selection_try + 1
        @stageCal.save
      end
      @user.award_try = @user.award_try + 1
      @user.save
      #@stage.save
      @stage_level = 1 + Integer(params[:stage_level])
      @is_wrong_answer=false
      
      
      ## [랭킹] 스테이지 클리어 보너스 부분
      checkRanking_forStage()

      
    else
      if @roomCal.last_stage_level == @stage_level
        @roomCal.try = @roomCal.try + 1
        @stage.try = @stage.try + 1
        if @stage.mode == 3
          @stageCal.selection_try = @stageCal.selection_try + 1
          @stageCal.save
        end
        @user.award_try = @user.award_try + 1
        @user.award_fail = @user.award_fail + 1
        @user.save
        #@stage.save
        @roomCal.save
        #puts "Stage/check : 오답, try 1증가  -> #{@roomCal.try}, 입력 #{params[:stage_answer]}, 출력 #{@stage.answer}"
      else
        #puts "Stage/check : 오답, 이미 푼 문제"
      end
      
    end
    
    
    # [난이도 측정] 난이도 측정 부분
    
    @stage.partial_difficulty = 5.00 * ((Float(@stage.try)-Float(@stage.pass))/Float(@stage.try))
    @stage.save
    
    @room.difficulty = 0 # 이 줄 없어도 작동하는지 체크
    @room.difficulty = @stages.sum(:partial_difficulty)
    
    @room.difficulty = @room.difficulty / Float(@stages.length)
    @room.save
   
  end 
  
  
#기타 Method

  def find_user
    @user = User.find(current_user.id)
  end

  def find_stages
    @stages = Stage.where("id <= :end_id AND room_id= :room_id", {:end_id => @room.publish_stage_id, :room_id => @room.id})
    
  end
  def find_stage
    @stage = Stage.find(params[:stage_id])
  end

  def find_room
    @room=Room.find(params[:room_id]) 
  end
  
  def find_roomCal
    @roomCal = RoomCal.find_by(user_id: current_user.id, room_id: params[:room_id])
  end
  
  
  def set_stageCal()
    @stageCal = StageCal.find_by(user_id: current_user.id, room_cal_id: @roomCal.id, stage_id: @stage.id)
    if @stageCal.nil?
      @stageCal = StageCal.new
      @stageCal.user_id = current_user.id
      @stageCal.room_cal_id = @roomCal.id 
      @stageCal.stage_id = @stage.id
      @stageCal.selection_try = 0
      @stageCal.save
    end
  end
   
  def find_stageCal
      @stageCal = StageCal.find_by(user_id: current_user.id, room_cal_id: @roomCal.id, stage_id: params[:stage_id])
  end
  
  def get_chats
    if @roomCal.mode == 2
      @chats = Chat.where("team_id == :team_id", {:team_id => @roomCal.team_id})
    else
      # @chats = Chat.where("user_id == :user_id AND room_id == :room_id", {:user_id => current_user.id, :room_id => params[:room_id]})
      @chats = Chat.where("user_id == :user_id", {:user_id => current_user.id} )
    end
  end
  
  
  def checkAnswer(stage, input_ans)
    
    if stage.mode==4
      @ans = stage.answer.split(",").map { |s| s.to_f }
    
      @input_ans_xys = input_ans.split(",").map { |s| s.to_f }
      @ansx =@input_ans_xys[0]
      @ansy =@input_ans_xys[1]
      @ans_s = @ans[2]/2
      if ((@ans[0]-@ans_s)< @ansx)&& (@ansx < (@ans[0]+@ans_s))&&((@ans[1]-@ans_s)<@ansy)&&(@ansy<(@ans[1]+@ans_s))
        return true
      else return false
      end
     
      
      
    else
      return stage.answer == input_ans || @mode3_Ans == 1 || @mode1_Ans==1 ||@mode2_Ans==1
    end
  end
  
  def checkRanking_forStage()
    
    if @stage.mode == 0 || @stage.mode == 1 || @stage.mode == 2 || @stage.mode == 4
      if @stageCal.usedhint1 == 1 && @stageCal.usedhint2 == 1 && @stageCal.usedhint3 == 1
        if @stageCal.useditem == 3
          @user.rank_point = @user.rank_point + 0.01*10
        elsif @stageCal.useditem == 2
          @user.rank_point = @user.rank_point + 0.007*10
        elsif @stageCal.useditem == 1
          @user.rank_point = @user.rank_point + 0.004*10
        else
          @user.rank_point = @user.rank_point + 0.001*10
        end
      elsif @stageCal.usedhint1 == 1 && @stageCal.usedhint2 == 1
        if @stageCal.useditem == 2
          @user.rank_point = @user.rank_point + 0.01*10
        elsif @stageCal.useditem == 1
          @user.rank_point = @user.rank_point + 0.007*10
        else
          @user.rank_point = @user.rank_point + 0.004*10
        end
      elsif @stageCal.usedhint1 == 1
        if @stageCal.useditem == 1
          @user.rank_point = @user.rank_point + 0.01*10
        else 
          @user.rank_point = @user.rank_point + 0.007*10
        end
      end
      @user.save
    elsif @stage.mode == 3
        if(@stageCal.usedhint1 == 1 && @stageCal.usedhint2 == 1 && @stageCal.usedhint3 == 1)
          if(@stageCal.selection_try >= 5)
            @user.rank_point = @user.rank_point + 0.001*10
          elsif(@stageCal.selection_try == 3 || @stageCal.selection_try == 4)
            @user.rank_point = @user.rank_point + 0.002*10
          elsif(@stageCal.selection_try == 1 || @stageCal.selection_try == 2)
            @user.rank_point = @user.rank_point + 0.003*10
          else
            @user.rank_point = @user.rank_point + 0.004*10
          end
        elsif(@stageCal.usedhint1 == 1 && @stageCal.usedhint2 == 1)
          if(@stageCal.selection_try >= 5)
            @user.rank_point = @user.rank_point + 0.003*10
          elsif(@stageCal.selection_try == 3 || @stageCal.selection_try == 4)
            @user.rank_point = @user.rank_point + 0.004*10
          elsif(@stageCal.selection_try == 1 || @stageCal.selecton_try == 2)
            @user.rank_point = @user.rank_point + 0.005*10
          else
            @user.rank_point = @user.rank_point + 0.006*10
          end
        elsif(@stageCal.usedhint1 == 1)
          if(@stageCal.selection_try >= 5)
            @user.rank_point = @user.rank_point + 0.005*10
          elsif(@stageCal.selection_try == 3 || @stageCal.selection_try == 4)
            @user.rank_point = @user.rank_point + 0.006*10
          elsif(@stageCal.selection_try == 1 || @stageCal.selecton_try == 2)
            @user.rank_point = @user.rank_point + 0.007*10
          else
            @user.rank_point = @user.rank_point + 0.008*10
          end
        else
          if(@stageCal.selection_try >= 5)
            @user.rank_point = @user.rank_point + 0.007*10
          elsif(@stageCal.selection_try == 3 || @stageCal.selection_try == 4)
            @user.rank_point = @user.rank_point + 0.008*10
          elsif(@stageCal.selection_try == 1 || @stageCal.selecton_try == 2)
            @user.rank_point = @user.rank_point + 0.009*10
          else
            @user.rank_point = @user.rank_point + 0.01*10
          end
        end  
    end
 

  end
  
  
  def getAnserInfoImageTheme(stage)
    @Ans_img = stage.answer.split(",").map { |s| s.to_f }
  
  end
  
  
  
  def stage_params
      params.require(:stage).permit(:title,:content,:hint1,:hint2,:hint3,
      :image,
      :answer,:answer2,:answer3,:mode,:selection_num1,:selection_num2,:selection_num3,:selection_num4,:selection_num5,:pattern_num1,:pattern_num2,:pattern_num3,:pattern_num4,:pattern_num5)
  end 
  
  
  def stage_params_without_image
      params.require(:stage).permit(:title,:content,:hint1,:hint2,:hint3,
      :answer,:answer2,:answer3,:mode,:selection_num1,:selection_num2,:selection_num3,:selection_num4,:selection_num5,:pattern_num1,:pattern_num2,:pattern_num3,:pattern_num4,:pattern_num5)
  end 
end