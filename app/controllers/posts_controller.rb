class PostsController < ApplicationController
    
  before_action :find_user, only: [:award, :awardapplying, :ranking, :ranking_season0place, :item]
  before_action :find_invites, only: [:notification] 
  before_action :find_roomCal, only: [:notification]
  def index 
  end
  
  def notification
    @INVITE_WAIT = 0
    @INVITE_ACCEPT = 1
    @INVITE_DENY = 2
  end
  
  def item
    @user.item_freehint = @user.item_freehint + 100
    @user.save
  end
  
  def award
      
      if @user.awardtitle_Z1 == 0 && @user.item_2018likelion == 1
        @user.awardtitle_Z1 == 1
      end
    
      if @user.awardtitle_A1 == 0 && @user.award_try >= 10
        @user.awardtitle_A1 = 1
      elsif @user.awardtitle_A2 == 0 && @user.award_try >= 50
        @user.awardtitle_A2 = 1
      elsif @user.awardtitle_A3 == 0 && @user.award_try >= 100
        @user.awardtitle_A3 = 1
      elsif @user.awardtitle_A4 == 0 && @user.award_try >= 200
        @user.awardtitle_A4 = 1
      elsif @user.awardtitle_H1 == 0 && @user.award_try >= 10000
        @user.awardtitle_H1 = 1
      end
      
      if @user.awardtitle_B1 == 0 && @user.award_fail >= 10 
        @user.awardtitle_B1 = 1
      elsif @user.awardtitle_B2 == 0 && @user.award_fail >= 50
        @user.awardtitle_B2 = 1
      elsif @user.awardtitle_B3 == 0 && @user.award_fail >= 100
        @user.awardtitle_B3 = 1
      elsif @user.awardtitle_B4 == 0 && @user.award_fail >= 200
        @user.awardtitle_B4 = 1
      end
      
      if @user.awardtitle_C1 == 0 && @user.award_clear >= 1
        @user.awardtitle_C1 = 1
      elsif @user.awardtitle_C2 == 0 && @user.award_clear >= 10
        @user.awardtitle_C2 = 1
      elsif @user.awardtitle_C3 == 0 && @user.award_clear >= 25
        @user.awardtitle_C3 = 1
      elsif @user.awardtitle_C4 == 0 && @user.award_clear >= 50
        @user.awardtitle_C4 = 1
      elsif @user.awardtitle_C5 == 0 && @user.award_clear >= 100
        @user.awardtitle_C5 = 1
      elsif @user.awardtitle_H2 == 0 && @user.award_clear >= 1000
        @user.awardtitle_H2 = 1
      end
      
      if @user.awardtitle_D1 == 0 && @user.award_make >= 10
        @user.awardtitle_D1 = 1
      elsif @user.awardtitle_D2 == 0 && @user.award_make >= 25
        @user.awardtitle_D2 = 1
      elsif @user.awardtitle_D3 == 0 && @user.award_make >= 50
        @user.awardtitle_D3 = 1
      elsif @user.awardtitle_D4 == 0 && @user.award_make >= 100
        @user.awardtitle_D4 = 1
      end
      
      if @user.awardtitle_E1 == 0 && @user.award_edit >= 20
        @user.awardtitle_E1 = 1
      elsif @user.awardtitle_E2 == 0 && @user.award_edit >= 100
        @user.awardtitle_E2 = 1
      elsif @user.awardtitle_E3 == 0 && @user.award_edit >= 200
        @user.awardtitle_E3 = 1
      end
      
      if @user.awardtitle_E4 == 0 && @user.award_distribute >= 10
        @user.awardtitle_E4 = 1
      elsif @user.awardtitle_E5 == 0 && @user.award_distribute >= 50
        @user.awardtitle_E5 = 1
      elsif @user.awardtitle_E6 == 0 && @user.award_distribute >= 100
        @user.awardtitle_E6 = 1
      end
      
      if @user.awardtitle_E7 == 0 && @user.award_delete >= 10 
        @user.awardtitle_E7 = 1
      elsif @user.awardtitle_E8 == 0 && @user.award_delete >= 50
        @user.awardtitle_E8 = 1
      elsif @user.awardtitle_E9 == 0 && @user.award_delete >= 100
        @user.awardtitle_E9 = 1
      end
      
      if @user.awardtitle_F1 == 0 && @user.award_single >= 1
        @user.awardtitle_F1 = 1
      elsif @user.awardtitle_F2 == 0 && @user.award_single >= 10
        @user.awardtitle_F2 = 1
      elsif @user.awardtitle_F3 == 0 && @user.award_single >= 25
        @user.awardtitle_F3 = 1
      elsif @user.awardtitle_F4 == 0 && @user.award_single >= 50
        @user.awardtitle_F4 = 1
      end
      
      if @user.awardtitle_G1 == 0 && @user.award_multi >= 1
        @user.awardtitle_G1 = 1
      elsif @user.awardtitle_G2 == 0 && @user.award_multi >= 10
        @user.awardtitle_G2 = 1
      elsif @user.awardtitle_G3 == 0 && @user.award_multi >= 25
        @user.awardtitle_G3 = 1
      elsif @user.awardtitle_G4 == 0 && @user.award_multi >= 50
        @user.awardtitle_G4 = 1
      end
      
      if @user.awardtitle_S0_1 == 0 && @user.rank_point > 0
        @user.awardtitle_S0_1 = 1
      elsif @user.awardtitle_S0_2 == 0 && @user.rank_point >= Float(3)
        @user.awardtitle_S0_2 = 1
      elsif @user.awardtitle_S0_3 == 0 && @user.rank_point >= Float(6)
        @user.awardtitle_S0_3 = 1
      elsif @user.awardtitle_S0_4 == 0 && @user.rank_point >= Float(9)
        @user.awardtitle_S0_4 = 1
      elsif @user.awardtitle_S0_5 == 0 && @user.rank_point >= Float(10)
        @user.awardtitle_S0_5 = 1
      end
      
      @user.save
      
  end
  
  def awardapplying
    @user.applying_award = params[:apply_this]
    @user.save
    
    redirect_to post_award_path
  end
  
  def create
    # 스테이지의 경우 room_id만 가지고 객체를 만든후에 사용자가 입력한 후에 저장을 하면 update가 된다.
    @stage = Stage.new
    @stage.room_id=params[:room_id]
    @stage.save
    
    redirect_to stage_manage_all_path(params[:room_id], edit_mode: true)
  end
  
  def mypage
    #현재 플레이 방탈출 부분
    @room_cals = @user.room_cals
  end
  
  def ranking
    
    #다음 등급까지 남은 포인트 계산 부분
    if @user.rank_point.round(2) >= 10.00
      @nextrank_ep = 0
      @nextrank_percent = 100
    elsif @user.rank_point.round(2) >= 9.00
      @nextrank_ep = Float(10) - @user.rank_point.round(2)
      @nextrank_percent = ((@user.rank_point.round(2)-Float(9))/Float(1))*100
    elsif @user.rank_point.round(2) >= 6.00
      @nextrank_ep = Float(9) - @user.rank_point.round(2)
      @nextrank_percent = ((@user.rank_point.round(2)-Float(6))/Float(3))*100
    elsif @user.rank_point.round(2) >= 3.00
      @nextrank_ep = Float(6) - @user.rank_point.round(2)
      @nextrank_percent = ((@user.rank_point.round(2)-Float(3))/Float(3))*100
    else
      @nextrank_ep = Float(3) - @user.rank_point.round(2)
      @nextrank_percent = (@user.rank_point.round(2)/Float(3))*100
    end
  end
  
  def ranking_season0place
    @users = User.all
    @player = User.find(current_user.id)
  end
  
  def find_invites
    @invites = current_user.invitations
  end
  
 
  
  def find_user
    @user=User.find(current_user.id)
  end
  
  def find_roomCal
    @roomCal = RoomCal.find_by(user_id: current_user.id, room_id: params[:room_id])
  end
  
end
