class Stage < ApplicationRecord
    mount_uploader :image, ImageUploader
    belongs_to :room
end
