class InvitesController < ApplicationController
  
  @@INVITE_WAIT = 0
  @@INVITE_ACCEPT =1
  @@INVITE_DENY = 2
  
  def create
    @invite_user = User.find_by("nickname = ?", params[:input_nick_name])
    if @invite_user
      
      puts "초대된 유저 정보 : #{@invite_user}"
      
      @invite = Invitation.find_by(room_id: params[:room_id],  team_id: params[:team_id],  user_id: @invite_user.id )
      if @invite.nil?
          @invite = Invitation.new
          @invite.room_id = Integer(params[:room_id])
          @invite.team_id = Integer(params[:team_id])
          @invite.user_id = @invite_user.id
          @invite.save
          puts "Invite 생성 : @invite"
          
          redirect_to room_team_path(params[:room_id],params[:team_id])
      elsif
          @already_invited= true
          puts "이미 초대된 유저"
          
      else
          @already_crazy= true
          puts "자기 자신을 초대..?"
      end
      
        
    else
      puts "초대 실패 파라미터 : #{params[:input_nick_name]}"
      # redirect_to '/'
      # redirect_to room_team_path(params[:room_id],params[:team_id])
    end
  
  end

  def update
    
    
    
    
    # 이거는 그저 임시용
    if Integer(params[:invite_id])== -1
      @invites = current_user.invitations
      @invites.each do |inv|
        inv.invite_accepted=0
        inv.save
      end
      redirect_to post_notification_path
    else
  
    @invite  = Invitation.find(params[:invite_id])
    @room_id = Room.find(@invite.room_id)
    @invite.invite_accepted = Integer(params[:invite_accepted])
    @invite.save
    
    if @invite.invite_accepted == @@INVITE_DENY
      redirect_to post_notification_path
    end
    
  end
  
    
  end
  
  def deleteAll
    @invites = Invitation.where("room_id = :room_id AND team_id = :team_id", { :room_id => params[:room_id], :team_id => params[:team_id]})
    @invites.each do |invites|
      @room_cal= RoomCal.find_by(user_id: invites.user_id, room_id: params[:room_id])
      @room_cal.destroy
    end
    @invites.delete_all
    
    @roomcal = RoomCal.find_by(user_id: current_user.id, room_id: params[:room_id])
    @roomcal.destroy
    
    redirect_to room_show_path(params[:room_id])
  end
end
