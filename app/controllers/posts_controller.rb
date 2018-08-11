class PostsController < ApplicationController
    
  before_action :find_invites, only: [:notification] 
  
  def index 
  end
  
  def notification
     @INVITE_WAIT = 0
    @INVITE_ACCEPT = 1
    @INVITE_DENY = 2
  end
  
  def mypage
    #현재 플레이 방탈출 부분
    @user=User.find(current_user.id)
    @room_cals = @user.room_cals
    
    
    
    
    
    #랭킹보기 페이지 부분
  end
  
  def ranking
    
  end
  
  
  def find_invites
    @invites = current_user.invitations
    
  end
  
end
