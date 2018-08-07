class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
       
      t.belongs_to :user
      t.belongs_to :team  
      t.integer :stage_id, default: -1
      t.string :content
      t.timestamps
    end
  end
end
