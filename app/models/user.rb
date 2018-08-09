class User < ApplicationRecord
  # rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # after_create :assign_default_role
  # def assign_default_role
  #   self.add_role(:newuser) if self.roles.blank?


  # end
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :room_cals , :dependent => :destroy 
  has_many :chats , :dependent => :destroy 
  
  
  has_many :rooms
  has_many :likes
  has_many :teams
  has_many :invitations
  
  def is_like? (room)
    Like.find_by(user_id: self.id, room_id: room.id).present?
  end
  
  

end
