class Room < ApplicationRecord
    mount_uploader :image, ImageUploader
    has_many :stages, :dependent => :destroy #종속된 포스트 삭제하면 싹다 삭제할것
    has_many :room_cals , :dependent => :destroy 
    has_many :invitations , :dependent => :destroy
    has_many :likes , :dependent => :destroy
    has_many :users, :dependent => :destroy
    
    belongs_to :user
end
