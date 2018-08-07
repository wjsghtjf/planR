class CreateRoomCals < ActiveRecord::Migration[5.2]
  def change
    create_table :room_cals do |t|
      t.belongs_to :room 
      t.belongs_to :user
      t.integer :team_id
      t.integer :last_stage_level  , default: 0
      t.integer :startTime
      t.integer :endTime
      t.integer :try , default: 0
      t.integer :is_pass , default: 0
      t.integer :like , default: 0
      t.integer :usedhint , default: 0
      t.timestamps
    end
  end
end
