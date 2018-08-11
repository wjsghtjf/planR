class ApplicationController < ActionController::Base
    before_action :authenticate_user!, except: [ :index ]
    before_action :configure_permitted_parameters, if: :devise_controller? 
    before_action :get_noti_count
    
    
    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
        devise_parameter_sanitizer.permit(:account_update, keys: [:nickname])
    end
    
    
    def get_noti_count
    #초대수락 페이지 부분
        
     @invite_new_count = current_user.invitations.select { |invite| invite.invite_accepted == 0 }.size if current_user
    end


end
