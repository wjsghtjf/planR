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
   
      
      t.integer :mode, default: 0
      # mode 0 = 시작 전 상태, mode 1 = 싱글플레이 상태, mode 2 = 멀티플레이 상태, 
      # mode 3 = 싱글플레이 완료상태, mode 4 = 멀티플레이 완료상태 
      # mode 5 = 멀티플레이 대기상태
      

      t.timestamps
    end
  end
end
