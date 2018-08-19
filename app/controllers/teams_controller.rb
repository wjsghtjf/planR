class TeamsController < ApplicationController
    
    def create
       
        @team = Team.create(user_id: current_user.id, room_id: params[:room_id])
        @team.save
        
        redirect_to room_team_path(params[:room_id], @team.id)
    end
end
