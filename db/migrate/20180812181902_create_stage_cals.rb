class CreateStageCals < ActiveRecord::Migration[5.2]
  def change
    create_table :stage_cals do |t|
      
      t.belongs_to :room_cal
      t.belongs_to :user
      t.belongs_to :stage
      
      t.integer :usedhint1 , default: 0
      t.integer :usedhint2 , default: 0
      t.integer :usedhint3 , default: 0
      t.integer :useditem, default: 0
      
      t.integer :selection_try, defualt: 0

      t.timestamps
      
    end
  end
end
