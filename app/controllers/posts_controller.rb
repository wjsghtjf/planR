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
    @user=User.find(current_user.id)
  end
  
  def ranking
    
  end
  
  
  def find_invites
    @invites = current_user.invitations
    
  end
end
