class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :title
      t.text :content
      t.float :difficulty 
      t.integer :likes      , default: 0
      t.integer :master_id  ,  null: false
      t.integer :publish_stage_id , default: 0
      t.timestamps
    end
  end
end
