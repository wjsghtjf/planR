class Invitation < ApplicationRecord
  
    belongs_to :room
    belongs_to :team
end
