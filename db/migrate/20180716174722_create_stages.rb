class CreateStages < ActiveRecord::Migration[5.2]
  def change
    create_table :stages do |t|
      t.belongs_to :room # ,  null: false
      t.string :title  , default: ""  
      t.text :content  , default: ""
      t.string :video
      t.integer :try    , default: 0
      t.integer :pass   , default: 0
      t.string :answer  , default: ""
      t.string :hint1 
      t.string :hint2
      t.string :hint3
      t.string :image
      t.integer :laststage , default: 0
            # 0 : 안 마지막 // 1 : 마지막
            
      t.float :partial_difficulty , default: 5.00

      
      t.timestamps
    end
  end
end
