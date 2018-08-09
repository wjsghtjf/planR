class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
       
      t.belongs_to :user
      t.integer :room_id
      t.integer :team_id
      t.belongs_to :stage
      t.string :content  , default: ""
      t.timestamps
    end
  end
end
