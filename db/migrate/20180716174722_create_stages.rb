class CreateStages < ActiveRecord::Migration[5.2]
  def change
    create_table :stages do |t|
      t.belongs_to :room # ,  null: false
      t.string :title  
      t.text :content 
      t.string :video
      t.integer :try    , default: 0
      t.integer :pass   , default: 0
      t.string :answer  
      t.string :hint1
      t.string :hint2
      t.string :hint3
      
      t.timestamps
    end
  end
end
