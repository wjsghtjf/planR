class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :title  , default: ""
      t.text :content  , default: ""
      t.float :difficulty , default: 0.00
      t.integer :clearcount , default: 0
      
      t.string :image
      t.belongs_to :user
      t.integer :publish_stage_id , default: 0
      
      
      t.timestamps
    end
  end
end
