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
      t.string :answer2 
      t.string :answer3
      t.string :answer4 
      t.string :answer5
      t.string :selection_num1
      t.string :selection_num2
      t.string :selection_num3
      t.string :selection_num4
      t.string :selection_num5
      t.string :pattern_num1
      t.string :pattern_num2
      t.string :pattern_num3
      t.string :pattern_num4
      t.string :pattern_num5
      t.string :hint1 
      t.string :hint2
      t.string :hint3
      t.integer :laststage , default: 0
            # 0 : 안 마지막 // 1 : 마지막
      t.integer :mode, default: 0
      # 0: 기본형 1: 자물쇠형 2: 순서형 3: 이미지클릭 4: 선택형
      t.float :partial_difficulty , default: 5.00

      
      t.string :image
      t.timestamps
    end
  end
end
