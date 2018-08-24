class ChatsController < ApplicationController
    
       
    def index
    end
    
    def create
        @chat= Chat.new(chats_params)
        @chat.save
        #puts "타임라인 글 작성 하기 성공, 요청한 room_id:#{params[:room_id]}, stage_level: #{params[:stage_level]}로 복귀"
        

        # JS로 대체 chats/create.html.erb
        # redirect_to stage_show_with_level_path(params[:room_id], params[:stage_level], is_opened: '1')
    end
    def delete
        @chat=Chat.find(params[:chat_id])
        @chat.destroy
        
        # JS로 대체 chats/delete.html.erb
        # redirect_to stage_show_path(params[:room_id], params[:stage_level], is_opened: '1'), method: post
    end

  def chats_params
      params.require(:chat).permit(:team_id,:user_id,:stage_id,:content,:image,:room_id)
  end    
end
