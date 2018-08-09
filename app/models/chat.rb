class Chat < ApplicationRecord
    
    belongs_to :stage
    belongs_to :user
end
