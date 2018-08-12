class CreateStageCals < ActiveRecord::Migration[5.2]
  def change
    create_table :stage_cals do |t|
      
      t.belongs_to :room_cals
      
      t.integer :usedhint1
      t.integer :usedhint2
      t.integer :usedhint3

      t.timestamps
    end
  end
end
