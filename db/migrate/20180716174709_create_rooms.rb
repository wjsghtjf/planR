class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :title  , default: ""
      t.text :content  , default: ""
      t.float :difficulty 
      t.integer :likes      , default: 0
      
      t.belongs_to :user
      t.integer :publish_stage_id , default: 0
      
      
      t.timestamps
    end
  end
end
