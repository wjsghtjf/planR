class RoomCal < ApplicationRecord
    belongs_to :user
    belongs_to :room
    has_many :stage_cals
    
end
