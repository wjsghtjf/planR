class StageCal < ApplicationRecord
    
    belongs_to :room_cal
    belongs_to :user
    belongs_to :stage
    
end
