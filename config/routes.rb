Rails.application.routes.draw do
  
  get 'invites/create'
  get 'invites/update'
  devise_for :users
  


  
  root 'posts#index'
  
  
#Room-View관련 라우팅 ↓
 
  #[랭킹] escapability 랭킹보기
  get 'posts/ranking', as: 'post_ranking'
  
  #[마이페이지] 마이페이지 
  get 'posts/mypage', as: 'post_mypage'
  
  #[마이페이지] Notification(초대수락페이지)
  get 'posts/notification', as: 'post_notification'
  
  #[초대하기] ??
  get 'invites/create', as: 'invite_create'
  post 'invites/update', as: 'invite_update'

  
  #[플레이] 방탈출 전체 목록 보기
  get 'rooms/index' , as: 'room_index'  
  
  #[플레이] 방탈출 소개페이지
  get 'rooms/:room_id/show', to: 'rooms#show', as: 'room_show'
  

  #[제작모드] 내가 만든 방탈출 목록보기
  get 'rooms/mine', as: 'room_mine' 
  #[제작모드] 방탈출 새로만들기
  get 'rooms/new', as: 'room_new'
  #[제작모드] 방탈출 수정하기
  get 'rooms/edit', as: 'room_edit'
  
  
#Room-Action 관련 라우팅 ↓
  
  #Room 만들기
  post 'rooms/create', to: 'rooms#create', as: 'room_create'
  #Room 수정하기
  post 'rooms/update', to: 'rooms#update', as: 'room_update'
  #Room 삭제하기
  
  post 'rooms/delete', to: 'rooms#delete', as: 'room_delete'
  #Room 베포하기
  post 'rooms/:room_id/publish/:stage_id', to: 'rooms#publish', as: 'room_publish'
  
#Room-like관련 라우팅
  get 'rooms/index', to: 'rooms#finish', as: 'room_finish'
  post 'rooms/index/like' , to: 'rooms#like'
  
  
#Team Management 관련 라우팅
  get 'rooms/:room_id/team/:team_id', to:'rooms#team', as:'room_team'
  # post 방식으로바꿀것
  get  "rooms/:room_id/team/:team_id/invites/create", to:"invites#create" , as:'room_invite'
  
#RoomCal 관련 라우팅 ↓
  
  #RoomCal 생성하기
  post 'rooms/:room_id/room_cals/create', to: 'room_cals#create', as: 'room_cal_create'
  
  
#Stage-View 관련 라우팅 ↓
  

  #[플레이] 스테이지 보기
  get "rooms/:room_id/stages/show", to: "stages#show"
  
  #[플레이] 힌트 보기
  post "rooms/:room_id/stages/:stages_id/hintpage/:hint_num", to: "stages#hintpage", as: 'stage_hintpage'
  
  #스테이지 보기 post방식 , stage_level 숨기는 용
  post "rooms/:room_id/stages/show", to: "stages#show", as: 'stage_show'
  
  # 정답 체크를 위한 라우팅
  post "rooms/:room_id/stages/check/:stage_id/:stage_level", to: "stages#check", as: 'stage_check'
  
  # 해당 레벨에 해당하는 스테이지 보기
  get "rooms/:room_id/stages/show/:stage_level" => "stages#show", as: 'stage_show_with_level'
  
  #[제작모드] 스테이지 보기 (stage_id 없는 경우에 해당하며 이경우는 가장 높은 레벨의 Stage를 보여주거나, stage가 없을 경우 보여주지 않는다.)
  get "rooms/:room_id/stages/manage" , to:"stages#manage", as: 'stage_manage_all'
  
  #[제작모드] 스테이지 보기 (stage_id에 해당하는 정보 띄우기)
  get "rooms/:room_id/stages/manage/:stage_id" , to: "stages#manage", as: 'stage_manage_each'
  
  #[제작모드] 스테이지 수정하기모드
  get "rooms/:room_id/stages/manage/:stage_id" , to: "stages#manage", as: 'stage_manage_edit'
    
 
#Stage-Action 관련 라우팅 ↓
  #[제작모드] 스테이지 새로 만들기
  post 'rooms/:room_id/stages/create', to: 'stages#create', as: 'stage_create'
  #[제작모드] 스테이지 수정하기
  post 'rooms/:room_id/stages/update/:stage_id', to: 'stages#update', as: 'stage_update'
  #[제작모드] 스테이지 삭제하기
  post 'rooms/:room_id/stages/delete', to: 'stages#delete', as: 'stage_delete'
  
 
#타임라인관련
  #타임라인 메세지 작성
  post 'chats/create', to: 'chats#create', as: 'chat_create'
  #타임라인 메세지 삭제
  post "chats/delete", to: "chats#delete", as: 'chat_delete'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end