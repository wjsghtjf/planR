class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      
      
      t.integer :invite_host
      t.integer :invite_guest
      t.integer :invite_accpeted, default: 0
      t.belongs_to :team
      t.belongs_to :room
      

      t.timestamps
    end
  end
end
