class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.belongs_to :user #팀을 만든사람의 정보
      t.timestamps
    end
  end
end
