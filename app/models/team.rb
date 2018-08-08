class Team < ApplicationRecord
    
    belongs_to :user
    
    has_many :chats, :dependent => :destroy #종속된 포스트 삭제하면 싹다 삭제할것
    has_many :invitations, :dependent => :destroy
    
end
