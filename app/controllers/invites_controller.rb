class InvitesController < ApplicationController
  
  @@INVITE_WAIT = 0
  @@INVITE_ACCEPT =1
  @@INVITE_DENY = 2
  
  def create
    @invite_user = User.find_by("nickname = ?", params[:input_invite_guest])
    # puts "초대된 유저의 닉네임:#{params[:input_invite_guest}"
    if @invite_user
      
      puts "초대된 유저 정보 : #{@invite_user}"
    
      # puts "초대된 유저 정보 : #{@invite_user}"
      
      @invite = Invitation.find_by("room_id = ? and team_id =? and invite_guest =? and invite_guest ", params[:room_id],params[:team_id],@invite_user.id)
      if @invite == nil
          @invite = Invitation.new
           @invite.room_id = params[:room_id] 
         @invite.team_id = params[:team_id]
      end
      
      @invite.invite_host = current_user.id
      @invite.invite_guest = @invite_user.id
      @invite.save
      
        #라우팅을통해 넘어온 room아이디
        
        redirect_to room_team_path(params[:room_id],params[:team_id])
    else
      puts "초대 실패 파라미터 : #{params[:input_invite_guest]}"
      redirect_to '/'
      # redirect_to room_team_path(params[:room_id],params[:team_id])
    end
  
  end

  def update
    
    # 이거는 그저 임시용
    if Integer(params[:invite_id])== -1
      @invites = Invitation.where("invite_guest = :user_id", { :user_id => current_user.id })
      @invites.each do |inv|
        inv.invite_accpeted=0
        inv.save
      end
      redirect_to post_notification_path
    else
    
    
    @invite  = Invitation.find(params[:invite_id])
    @invite.invite_accpeted = Integer(params[:invite_accpeted])
    @invite.save
    
    if @invite.invite_accpeted==@@INVITE_ACCEPT
      redirect_to room_team_path(@invite.room_id, @invite.team_id)
    else
      redirect_to post_notification_path
    end
  
    end
  end
end
