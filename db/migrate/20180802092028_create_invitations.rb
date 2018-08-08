class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      
      
      t.belongs_to :user #초대 받은 사람의 u_id
      t.belongs_to :team
      t.belongs_to :room
      
      t.integer :invite_accepted, default: 0
      # 0 = 대기, 1 = 초대 수락, 2 = 초대 거절, 3 = 숙면중

      t.timestamps
    end
  end
end
