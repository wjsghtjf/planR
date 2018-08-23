class ApplicationController < ActionController::Base
    before_action :authenticate_user!, except: [ :index ]
    before_action :configure_permitted_parameters, if: :devise_controller? 
    before_action :expbar
    
    
    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
        devise_parameter_sanitizer.permit(:account_update, keys: [:nickname])
    end
    
    
    
    
    def expbar
            #현재 플레이 방탈출 부분
    if user_signed_in?
    @user=User.find(current_user.id)
    @room_cals = @user.room_cals
    
    
    #다음 등급까지 남은 포인트 계산 부분
    if @user.rank_point.round(2) == 10.00
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
    end
    
    

end
